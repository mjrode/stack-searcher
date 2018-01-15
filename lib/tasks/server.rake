namespace :server do
  desc 'Start Rails server and Webpack dev server'
  task start: :environment do
    sh 'foreman start -f Procfile.dev -p 3000'
  end

end
