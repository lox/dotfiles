
export AWS_HOME=~/.aws
export AWS_CONFIG_FILE=~/.aws/config
export AWS_DEFAULT_REGION=us-east-1
export AWS_IAM_HOME="/usr/local/opt/aws-iam-tools/libexec"
export AWS_ELB_HOME="/usr/local/opt/elb-tools/libexec"
export CS_HOME="/usr/local/opt/aws-cloudsearch"

#export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
#export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
export EC2_HOME="/usr/local/opt/ec2-api-tools/libexec"

# helper command for swapping profiles
function awp {
  export AWS_DEFAULT_PROFILE=$1
  export AWS_CREDENTIAL_FILE=$HOME/.aws/$1/credentials
  export RPROMPT="<aws:$AWS_DEFAULT_PROFILE>"
  export AWS_ACCESS_KEY=$(grep '^AWSAccessKeyId' "$AWS_CREDENTIAL_FILE" | cut -d= -f2)
  export AWS_SECRET_KEY=$(grep '^AWSSecretKey'   "$AWS_CREDENTIAL_FILE" | cut -d= -f2)
}

if [ -d ~/.aws ] ; then
  awp 99designs
fi

# aws-cli helpers
# ----------------------------

# list rds instances
function rds_instances {
  aws rds describe-db-instances | jq '[.DBInstances[]]'
}

# list ec2 instances, optionally with Tag=Value filters
function ec2_instances {
  if (($+1)); then
    array=(${(s/=/)1})
    ec2_instances | jq_tag $array[1] $array[2]
  else
    aws ec2 describe-instances | \
      jq '[.Reservations[].Instances[] | select(.State.Name == "running")]'
  fi
}

# extract just the hostnames
function ec2_hostnames {
  if [[ ! -z "$1" && "$1" == "-t" ]]; then
    jq -r '.[] | {(.PublicDnsName): .Tags}'
  else
    jq -r '.[] | .PublicDnsName'
  fi
}

# open an iterm with ssh connections to hosts from stdin
function ec2_ssh {
  ec2_instances $@ | ec2_hostnames | mssh -u ubuntu
}

# tests whether a host is ssh accessible
function is_ssh_accessible {
  output=$(ssh -n \
    -o ForwardAgent=yes \
    -o StrictHostKeyChecking=no \
    -o ConnectTimeout=1 \
    -o PasswordAuthentication=no $1 true 2>&1)
  return $?
}

# jq pipeline helpers
# -----------------------------

function jq_uniq_tag {
  if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [tag]" >&2
    return 1
  fi
  jq --arg key $1 -r '.[] | select(has("Tags")) | .Tags[] | select(contains({ Key: $key})) | .Value ' | uniq
}

function jq_tag {
  if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [tag] [value]]" >&2
    return 1
  fi
  jq --arg key $1 --arg value $2 '[.[] | select(has("Tags")) | select(.Tags[] | (.Key == $key) and .Value == $value)]'
}

function jq_any {
  jq -c '.[]' | awk 'BEGIN { srand() } rand() >= 0.5 { print; exit }' | jq '.'
}

# functions for ssh tunneling to RDS
# --------------------------------

function _find_ec2_instance() {
  echo -n "Finding ec2 instance (Role=$1)... " >&2
  EC2_INSTANCE=$(ec2_instances | jq_tag Role $1 | jq_any | jq -r '.PublicDnsName')
  if [[ -z "$EC2_INSTANCE" ]]; then
    echo "Failed ✗" >&2
    return 1
  else
    echo "$EC2_INSTANCE ✓" >&2
  fi
}

function _find_rds_instance() {
  echo -n "Finding rds instance (Name=$1)... " >&2
  RDS_INSTANCE=$(rds_instances | jq -r --arg db $1 '.[] | select(.DBInstanceIdentifier == $db) | .Endpoint.Address')
  if [[ -z "$RDS_INSTANCE" ]]; then
    echo "Failed ✗" >&2
    return 1
  else
    echo "$RDS_INSTANCE ✓" >&2
  fi
}

# opens an rds tunnel
# args: <instance group> <rds instance>
function rds_tunnel() {
  if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <instance group> <rds instance>" >&2
    return 1
  fi

  _find_ec2_instance $1 || return 1
  _find_rds_instance $2 || return 1

  echo "Fowarding local port 3307..." >&2
  ssh -N -L 3307:$RDS_INSTANCE:3306 ubuntu@$EC2_INSTANCE &
}

# opens an rds tunnel
# args: <instance group> <rds instance> <mysql user>
function rds_shell() {
  if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <instance group> <rds instance> <mysql user>" >&2
    return 1
  fi
  _find_ec2_instance $1 || return 1
  _find_rds_instance $2 || return 1

  echo "Creating SSH tunnel..." >&2
  ssh -f -N -L 3307:$RDS_INSTANCE:3306 ubuntu@$EC2_INSTANCE || return 1

  set_title "$3@$RDS_INSTANCE"
  set_window_color 731817 0.1

  PASSWD=$(security find-generic-password -wa "$3@$RDS_INSTANCE/")

  echo "Connecting mysql..." >&2
  mysql -h 127.0.0.1 --port 3307 -u $3 -p"$PASSWD"

  set_window_color $DEFAULT_TERMINAL_COLOR $DEFAULT_TERMINAL_OPACITY
}

# runs mysqldump on an rds instance
# args: <instance group> <rds instance> <mysql user> [... mysqldump params]
function rds_mysqldump() {
  if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <instance group> <rds instance> <mysql user> [... mysqldump params]" >&2
    return 1
  fi
  _find_ec2_instance $1 || return 1
  _find_rds_instance $2 || return 1

  echo "Creating SSH tunnel..." >&2
  ssh -f -N -L 3307:$RDS_INSTANCE:3306 ubuntu@$EC2_INSTANCE || return 1

  echo "Searching keychain for $3@$RDS_INSTANCE/" >&2
  PASSWD=$(security find-generic-password -wa "$3@$RDS_INSTANCE/")

  echo "Connecting mysqldump (using --single-transaction)..." >&2
  if (( $+commands[pv] )) ; then
    mysqldump --single-transaction -h 127.0.0.1 --port 3307 -u $3 -p"$PASSWD" $@[4,$@[(I)$@[-1]]] | pv
  else
    mysqldump --single-transaction -h 127.0.0.1 --port 3307 -u $3 -p"$PASSWD" $@[4,$@[(I)$@[-1]]]
  fi
}


