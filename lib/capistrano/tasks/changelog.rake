namespace :deploy do
  task :changelog do
    on primary :web do
      set :current_revision, fetch(:current_revision, fetch(:branch))

      releases = capture(:ls, '-xt', releases_path).split
      last_release_id = capture(:cat, releases_path.join(releases[0]).join('REVISION'))

      changelog = capture(:git, "--git-dir=#{repo_path}", '--no-pager', 'log', '--pretty=oneline',  "#{last_release_id}..#{fetch(:current_revision)}")

      info "Changes between #{last_release_id} and #{fetch(:current_revision)} releases"
      info changelog
    end
  end
end
