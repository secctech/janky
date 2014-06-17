module Janky
  module Notifier
    # Continuous Deployment notifier.
    class Deploy
      def self.completed(build)
        success = build.green?
        branch  = build.branch

        puts "Processing #{build.repo_name}..."

        if branch == "continuous-deployment-testing"
          puts "Cloning API..."

          `git clone git@github.com:secctech/api.git tmp/deploy/api`
        end
      end
    end
  end
end
