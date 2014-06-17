module Janky
  module Notifier
    # Continuous Deployment notifier.
    class Deploy
      def self.completed(build)
        success = build.green?
        branch  = build.branch_name

        puts "Processing #{build.repo_name}..."

        if branch == "staging"
          puts "Cloning API..."

          `git clone git@github.com:secctech/api.git tmp/api`
          `cd tmp/api && git checkout -b staging remotes/origin/staging`
          `cd tmp/api && git push -f git@heroku.com:secondchance-api-staging.git HEAD:master`
        end
      end
    end
  end
end
