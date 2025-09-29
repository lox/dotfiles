
# cdx - Run codex with gpt-5-codex model
cdx() {
  if [[ "$1" == "update" ]]; then
    npm install -g @openai/codex@latest
  else
    codex \
      --model 'gpt-5-codex' \
      --dangerously-bypass-approvals-and-sandbox \
      -c model_reasoning_summary_format=experimental \
      --search "$@"
  fi
}
