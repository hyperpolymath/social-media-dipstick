;; SPDX-License-Identifier: AGPL-3.0-or-later
;; SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell
;; ECOSYSTEM.scm — social-media-dipstick

(ecosystem
  (version "1.0.0")
  (name "social-media-dipstick")
  (type "project")
  (purpose "> Automated system to monitor social media platform policies and deliver 6-monthly guidance to NUJ members")

  (position-in-ecosystem
    "Part of hyperpolymath ecosystem. Follows RSR guidelines.")

  (related-projects
    (project (name "rhodium-standard-repositories")
             (url "https://github.com/hyperpolymath/rhodium-standard-repositories")
             (relationship "standard")))

  (what-this-is "> Automated system to monitor social media platform policies and deliver 6-monthly guidance to NUJ members")
  (what-this-is-not "- NOT exempt from RSR compliance"))
