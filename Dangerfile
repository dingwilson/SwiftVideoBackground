# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn('PR is classed as Work in Progress', sticky: false) if github.pr_title.include? '[WIP]'

# Ensure a clean commits history
if git.commits.any? { |c| c.message =~ /^Merge branch '#{github.branch_for_base}'/ }
  fail('Please rebase to get rid of the merge commits in this PR', sticky: false)
end

# Run SwiftLint
swiftlint.lint_files

# Report any xcodebuild warnings/errors
xcode_summary.report 'xcodebuild.json'
