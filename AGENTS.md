# Agent Development Guide

## General Development Commands
- **Format Go**: `go fmt ./...`
- **Test Go**: `go test ./...`
- **Test with coverage**: `go test -cover ./...`
- **Build**: `go build ./...`
- **Mod tidy**: `go mod tidy`
- **Vet code**: `go vet ./...`
- **Install dependencies**: `go mod download`

## Go Best Practices
- **Package structure**: Use clear, descriptive package names (avoid generic names like `util`)
- **Naming**: Use camelCase for private, PascalCase for public exports
- **Error handling**: Always handle errors explicitly, use `fmt.Errorf` for wrapping
- **Context**: Pass `context.Context` as first parameter for cancellation/timeouts
- **Interfaces**: Keep interfaces small and focused (prefer composition)
- **Testing**: Use table-driven tests, test files end with `_test.go`
- **Documentation**: Comment all public functions/types with proper godoc format

## Code Style & Conventions
- **Formatting**: Always run `go fmt` before committing
- **Imports**: Group standard library, third-party, and local imports separately
- **Variables**: Use short variable names in small scopes, descriptive names in larger scopes
- **Constants**: Use `const` blocks for related constants
- **Struct tags**: Use consistent tag formatting (json, yaml, etc.)
- **Error types**: Create custom error types for domain-specific errors

## Git & Development Workflow
- **Branch naming**: Use simple descriptive names without prefixes
- **Commits**: Commit signing enabled, write clear commit messages
- **Dependencies**: Keep `go.mod` clean, use `go mod tidy` regularly
- **Security**: Never commit secrets, use environment variables or secure vaults
- **CI/CD**: Ensure tests pass before merging, use automated linting

## Performance & Quality
- **Benchmarking**: Use `go test -bench=.` for performance testing
- **Profiling**: Use `go tool pprof` for CPU/memory profiling
- **Race detection**: Run tests with `-race` flag
- **Static analysis**: Use `golangci-lint` for comprehensive code analysis
- **Dependency management**: Regular security updates with `go list -m -u all`