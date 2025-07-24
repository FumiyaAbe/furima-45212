# Capistranoのバージョンを固定（バージョン変更によるトラブル防止）
lock '3.19.2'

# Capistranoのログに表示されるアプリ名
set :application, 'furima-45212'

# リモートリポジトリのURL（SSH形式で指定）
set :repo_url,  'git@github.com:FumiyaAbe/furima-45212.git'
set :branch, 'main'

# バージョンが変わっても共通で参照されるディレクトリ
set :linked_dirs, fetch(:linked_dirs, []).push(
  'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets',
  'vendor/bundle', 'public/system', 'public/uploads'
)

# rbenvの設定
set :rbenv_type, :user
set :rbenv_ruby, '3.2.0'

# 使用するSSH鍵
set :ssh_options, auth_methods: ['publickey'],
                  keys: ['~/.ssh/furima-45212_keypair_v2.pem']

# Unicornの設定
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }

# 保持するリリースの数（過去5回分を保持）
set :keep_releases, 5

# デプロイ後にUnicornを再起動する
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
set :branch, 'main'