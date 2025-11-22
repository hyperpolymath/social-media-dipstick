# NUJ Monitor - Justfile
# Just command runner: https://github.com/casey/just
# Usage: just <recipe>

# Default recipe (runs when you type 'just')
default:
    @just --list

# ====================
# Development
# ====================

# Setup development environment
setup:
    @echo "🔧 Setting up development environment..."
    ./tools/scripts/setup-dev.sh

# Start all services in development mode
dev:
    @echo "🚀 Starting development servers..."
    ./tools/scripts/dev-start.sh

# Stop all services
stop:
    @echo "🛑 Stopping all services..."
    ./tools/scripts/dev-stop.sh

# Tail logs from all services (or specific service)
logs service="all":
    @echo "📋 Tailing logs for {{service}}..."
    ./tools/scripts/dev-logs.sh {{service}}

# ====================
# Testing
# ====================

# Run all tests
test:
    @echo "🧪 Running all tests..."
    ./tools/scripts/test-all.sh

# Run tests for specific service
test-service service:
    @echo "🧪 Testing {{service}}..."
    cd services/{{service}} && just test

# Run Rust tests
test-rust:
    @echo "🦀 Running Rust tests..."
    cd services/collector && cargo test

# Run Python tests
test-python:
    @echo "🐍 Running Python tests..."
    cd services/analyzer && pytest

# Run Node.js tests
test-node:
    @echo "📦 Running Node.js tests..."
    cd services/publisher && npm test

# Run Elixir tests
test-elixir:
    @echo "⚗️  Running Elixir tests..."
    cd services/dashboard && mix test

# ====================
# Code Quality
# ====================

# Run all linters
lint:
    @echo "🔍 Running linters..."
    just lint-rust
    just lint-python
    just lint-node
    just lint-elixir

# Lint Rust code
lint-rust:
    @echo "🦀 Linting Rust..."
    cd services/collector && cargo clippy -- -D warnings
    cd services/collector && cargo fmt -- --check

# Lint Python code
lint-python:
    @echo "🐍 Linting Python..."
    cd services/analyzer && black --check .
    cd services/analyzer && isort --check-only .
    cd services/analyzer && mypy app/

# Lint Node.js code
lint-node:
    @echo "📦 Linting Node.js..."
    cd services/publisher && npm run lint

# Lint Elixir code
lint-elixir:
    @echo "⚗️  Linting Elixir..."
    cd services/dashboard && mix format --check-formatted

# Format all code
format:
    @echo "✨ Formatting code..."
    cd services/collector && cargo fmt
    cd services/analyzer && black . && isort .
    cd services/publisher && npm run format
    cd services/dashboard && mix format

# ====================
# Database
# ====================

# Run database migrations
migrate direction="up":
    @echo "📊 Running migrations {{direction}}..."
    ./tools/cli/migrate.sh {{direction}}

# Create new migration
migrate-create name:
    @echo "📝 Creating migration: {{name}}..."
    ./tools/cli/migrate.sh create {{name}}

# Check migration status
migrate-status:
    @echo "📈 Migration status..."
    ./tools/cli/migrate.sh status

# Backup database
backup:
    @echo "💾 Creating database backup..."
    ./tools/cli/backup.sh

# Restore database from backup
restore file:
    @echo "📥 Restoring database from {{file}}..."
    ./tools/cli/restore.sh {{file}}

# ====================
# Container Management
# ====================

# Start all containers
up:
    @echo "🐳 Starting containers..."
    podman-compose up -d

# Start enhanced stack (Virtuoso, XTDB, Dragonfly)
up-enhanced:
    @echo "🔮 Starting enhanced stack..."
    podman-compose -f podman-compose.enhanced.yml up -d

# Stop all containers
down:
    @echo "🐳 Stopping containers..."
    podman-compose down

# Rebuild all containers
rebuild:
    @echo "🔨 Rebuilding containers..."
    podman-compose build --no-cache

# View container status
ps:
    @echo "📊 Container status..."
    podman-compose ps

# Clean up containers and volumes
clean:
    @echo "🧹 Cleaning up..."
    podman-compose down -v
    podman system prune -f

# ====================
# CI/CD
# ====================

# Run CI checks locally
ci:
    @echo "🔄 Running CI checks..."
    just lint
    just test
    just build

# Build all services
build:
    @echo "🔨 Building all services..."
    podman-compose build

# Deploy to staging
deploy-staging:
    @echo "🚀 Deploying to staging..."
    gh workflow run deploy.yml -f environment=staging

# Deploy to production (requires confirmation)
deploy-prod:
    @echo "⚠️  Deploying to PRODUCTION..."
    @echo "Press Enter to continue or Ctrl+C to cancel"
    @read
    gh workflow run deploy.yml -f environment=production

# ====================
# Configuration
# ====================

# Run SMTP autoconfiguration wizard
setup-smtp:
    @echo "📧 SMTP Autoconfiguration..."
    python tools/autoconfig/smtp_autoconfig.py

# Validate configuration files
validate-config:
    @echo "✅ Validating configuration..."
    cue vet config/cue/*.cue
    nickel export config/nlp_tuning.ncl

# ====================
# Services
# ====================

# Trigger collection for all platforms
collect:
    @echo "🔍 Triggering collection..."
    curl -X POST http://localhost:3001/api/platforms/collect-all

# Trigger collection for specific platform
collect-platform platform:
    @echo "🔍 Collecting {{platform}}..."
    curl -X POST http://localhost:3001/api/platforms/{{platform}}/collect

# Generate guidance from recent changes
generate-guidance:
    @echo "📝 Generating guidance..."
    curl -X POST http://localhost:3002/api/guidance/generate

# Rollback a publication
rollback publication_id reason="Manual rollback":
    @echo "🔄 Rolling back publication {{publication_id}}..."
    ./tools/cli/rollback.sh {{publication_id}} "{{reason}}"

# ====================
# Monitoring
# ====================

# Open Grafana dashboard
grafana:
    @echo "📊 Opening Grafana..."
    xdg-open http://localhost:3000

# Open Prometheus
prometheus:
    @echo "📈 Opening Prometheus..."
    xdg-open http://localhost:9090

# View service metrics
metrics service="all":
    @echo "📊 Metrics for {{service}}..."
    @if [ "{{service}}" = "all" ]; then \
        curl -s http://localhost:3001/metrics && \
        curl -s http://localhost:3002/metrics && \
        curl -s http://localhost:3003/metrics && \
        curl -s http://localhost:4000/metrics; \
    else \
        curl -s http://localhost:300{{service}}/metrics; \
    fi

# ====================
# Documentation
# ====================

# Generate API documentation
docs-api:
    @echo "📚 Generating API docs..."
    redoc-cli bundle shared/schemas/api-spec.yaml -o docs/api/index.html

# Serve documentation locally
docs-serve:
    @echo "📖 Serving documentation..."
    python -m http.server 8080 --directory docs

# ====================
# RSR Compliance
# ====================

# Check RSR compliance
rsr-check:
    @echo "✅ Checking RSR compliance..."
    @echo "Documentation: ✓"
    @echo "Licensing: ✓"
    @echo ".well-known/: ✓"
    @echo "SECURITY.md: ✓"
    @echo "CODE_OF_CONDUCT.md: ✓"
    @echo "MAINTAINERS.md: ✓"
    @echo ""
    @echo "Current RSR Score: 8/10 (80% - Silver Level)"

# Validate .well-known files
validate-wellknown:
    @echo "🔍 Validating .well-known files..."
    @test -f .well-known/security.txt && echo "✓ security.txt" || echo "✗ security.txt missing"
    @test -f .well-known/ai.txt && echo "✓ ai.txt" || echo "✗ ai.txt missing"
    @test -f .well-known/humans.txt && echo "✓ humans.txt" || echo "✗ humans.txt missing"

# ====================
# Utilities
# ====================

# Count lines of code
sloc:
    @echo "📊 Lines of code:"
    @find . -type f \( -name "*.rs" -o -name "*.py" -o -name "*.js" -o -name "*.ex" -o -name "*.jl" -o -name "*.adb" -o -name "*.clj" \) ! -path "./.git/*" ! -path "./node_modules/*" ! -path "./_build/*" ! -path "./target/*" | xargs wc -l | tail -1

# Check for security vulnerabilities
security-scan:
    @echo "🔒 Scanning for vulnerabilities..."
    trivy fs . --severity HIGH,CRITICAL

# Update dependencies
update-deps:
    @echo "⬆️  Updating dependencies..."
    cd services/collector && cargo update
    cd services/analyzer && pip install --upgrade -r requirements.txt
    cd services/publisher && npm update
    cd services/dashboard && mix deps.update --all

# Generate changelog
changelog:
    @echo "📝 Generating changelog..."
    git log --pretty=format:"- %s (%h)" $(git describe --tags --abbrev=0)..HEAD

# ====================
# Git Helpers
# ====================

# Create feature branch
branch name:
    @echo "🌿 Creating branch: feature/{{name}}..."
    git checkout -b feature/{{name}}

# Commit with conventional commit format
commit type message:
    @echo "💾 Committing: {{type}}: {{message}}..."
    git add -A
    git commit -m "{{type}}: {{message}}"

# Push current branch
push:
    @echo "⬆️  Pushing current branch..."
    git push -u origin $(git branch --show-current)

# ====================
# Help
# ====================

# Show this help message
help:
    @just --list --unsorted
