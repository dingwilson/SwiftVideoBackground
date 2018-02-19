# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn('PR is classed as Work in Progress', sticky: false) if github.pr_title.include? '[WIP]'

# Run SwiftLint
swiftlint.lint_files

# Report any xcodebuild warnings/errors
xcode_summary.report 'xcodebuild.json'
