# Security Policy

## Supported Versions

We release security updates for the following versions:

| Version | Supported          | Status      |
| ------- | ------------------ | ----------- |
| 0.1.x   | :white_check_mark: | Development |
| main    | :white_check_mark: | Current     |

## Reporting a Vulnerability

**Please DO NOT report security vulnerabilities through public GitHub issues.**

### Preferred Method

Email: **security@nuj.org.uk**

Include:
- Type of vulnerability (e.g., XSS, SQL injection, authentication bypass)
- Full paths of affected source files
- Location of vulnerable code (tag/branch/commit/URL)
- Step-by-step reproduction instructions
- Proof-of-concept or exploit code (if possible)
- Impact assessment
- Suggested fix (optional)

### Response Timeline

- **Acknowledgment**: Within 48 hours
- **Initial assessment**: Within 7 days
- **Status updates**: Every 7 days
- **Fix timeline**: 30-90 days (depending on severity)

### Severity Levels

#### Critical (CVSS 9.0-10.0)
- Remote code execution
- Authentication bypass
- Data breach of member information
- **Response**: Immediate (24-48 hours)

#### High (CVSS 7.0-8.9)
- Privilege escalation
- SQL injection
- XSS with data exfiltration
- **Response**: 7 days

#### Medium (CVSS 4.0-6.9)
- CSRF
- Information disclosure
- Denial of service
- **Response**: 30 days

#### Low (CVSS 0.1-3.9)
- Minor information disclosure
- Best practice violations
- **Response**: 90 days

## Disclosure Policy

### Coordinated Disclosure

We follow **responsible disclosure**:

1. **Report received**: Acknowledged within 48 hours
2. **Validation**: Reproduce and assess (7 days)
3. **Fix development**: Patch created (30-90 days)
4. **Testing**: Verify fix in staging
5. **Release**: Deploy to production
6. **Public disclosure**: 90 days after fix OR by mutual agreement

### Public Disclosure

After fix deployment:
- Security advisory published (GitHub Security Advisories)
- CVE requested (if applicable)
- CHANGELOG.md updated
- Credit given to researcher (if desired)

## Security Measures

### Infrastructure

- **Encryption in transit**: TLS 1.3 for all HTTP traffic
- **Encryption at rest**: Database encryption enabled
- **Secrets management**: Environment variables, never committed
- **Access control**: Role-based permissions (RBAC)
- **Audit logging**: All sensitive actions logged

### Application Security

- **Input validation**: All user inputs sanitized
- **Output encoding**: XSS prevention
- **CSRF protection**: Tokens required for state-changing operations
- **SQL injection prevention**: Parameterized queries only
- **Rate limiting**: API throttling enabled
- **Authentication**: Multi-factor authentication (MFA) supported

### 19-Layer Safety Guardrail System

Our publisher service implements 19 safety layers:

1-5: **Never Auto-Publish**
- Human approval required
- 5-minute grace period
- Test group validation
- Auto-rollback capability
- Emergency stop button

6-10: **Monitoring**
- Platform change notifications
- Service health monitoring
- False positive detection
- Delivery success tracking
- Anomaly detection

11-15: **Data Protection**
- Member data encryption
- Role-based access control
- Complete audit logging
- GDPR compliance
- Data retention policies

16-19: **Operational**
- Rate limiting
- Graceful degradation
- Backup systems
- Disaster recovery

### Dependencies

- **Automated scanning**: Dependabot enabled
- **License compliance**: GPL-3.0 compatible only
- **Version pinning**: Lock files committed
- **Update policy**: Security patches within 7 days

## Scope

### In Scope

- All services in `services/` directory
- Infrastructure configurations (`infrastructure/`)
- Database schemas (`infrastructure/database/`)
- API endpoints (REST, GraphQL, SPARQL)
- Authentication and authorization systems
- Email delivery system
- Admin interfaces

### Out of Scope

- Third-party dependencies (report to upstream)
- Theoretical vulnerabilities without proof-of-concept
- Social engineering attacks
- Physical security of servers
- Denial of service (unless amplification vector)
- Rate limit bypasses (unless leading to abuse)

## Known Security Considerations

### By Design

1. **Email delivery grace period**: 5-minute window for rollback
   - Risk: Delayed breach notification
   - Mitigation: Emergency stop button bypasses grace period

2. **AI-generated content**: Uses OpenAI GPT-4
   - Risk: Prompt injection, biased outputs
   - Mitigation: Human approval required, content review

3. **Platform API credentials**: Stored encrypted
   - Risk: Credential leakage if database compromised
   - Mitigation: Encrypted at rest, limited access

4. **Multi-language stack**: 9 different languages
   - Risk: Increased attack surface
   - Mitigation: Language-specific security practices, sandboxing

### Future Enhancements

- [ ] Hardware security keys for admin access
- [ ] Automated penetration testing
- [ ] Security training for contributors
- [ ] Bug bounty program (post-1.0 release)

## Security Champions

Current security contacts:

- **Primary**: security@nuj.org.uk
- **Backup**: Jonathan (NUJ Project Lead)

## Acknowledgments

We thank the following researchers for responsible disclosure:

*(No vulnerabilities reported yet)*

### Recognition

- Public acknowledgment in SECURITY.md
- Credit in security advisory
- Listed in CHANGELOG.md
- GitHub Security Advisories credit

### Bounty Program

Not currently available. May be considered for v1.0 release.

## Compliance

### Standards

- **OWASP Top 10**: Addressed
- **CWE Top 25**: Mitigated
- **GDPR**: Compliant (EU data protection)
- **SOC 2**: Planned for enterprise deployment

### Audits

No external security audits performed yet.
Planned for v1.0 release.

## Security Resources

### For Users

- [GitHub Security Best Practices](https://docs.github.com/en/code-security)
- [OWASP Web Security Testing Guide](https://owasp.org/www-project-web-security-testing-guide/)

### For Contributors

- [Secure Coding Guidelines](CONTRIBUTING.md#security)
- [Dependency Security](CONTRIBUTING.md#dependencies)

## Updates

This policy is versioned with the codebase.
Check git history for changes.

**Last updated**: 2025-11-22

---

**PGP Key**: Available at `.well-known/pgp-key.txt` (when implemented)
**RFC 9116**: Compliant via `.well-known/security.txt`
