module Janky
  module Notifier
    # Continuous Deployment notifier.
    class Deploy
      def self.completed(build)
        success = build.green?
        branch  = build.branch_name

        if branch == "staging"
          Thread.new do
            FileUtils.rm_rf "tmp/api"

            `git clone git@github.com:secctech/api.git tmp/api`
            `cd tmp/api && git checkout -b staging remotes/origin/staging`
            `cd tmp/api && git push -f git@heroku.com:secondchance-api-staging.git HEAD:master`
          end
        end
      end
    end
  end
end
