# Make sure the Apt package lists are up to date, so we're downloading versions that exist.
cookbook_file "apt-sources.list" do
  path "/etc/apt/sources.list"
end
execute 'apt_update' do
  command 'apt-get update'
end

# Base configuration recipe in Chef.
package "wget"
package "ntp"
cookbook_file "ntp.conf" do
  path "/etc/ntp.conf"
end
execute 'ntp_restart' do
  command 'service ntp restart'
end

# Copy bash aliases
cookbook_file "bash_aliases" do
  path "/home/vagrant/.bash_aliases"
end

# Install and configure git
package "git"
execute "git name" do
  command 'git config --global user.name "Jagrajan Bhullar"'
end
execute "git email" do
  command 'git config --global user.email jag@jagrajan.com'
end

# Install Vundle and specify packages
package "vim"
directory "/home/vagrant/.vim" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end
directory "/home/vagrant/.vim/bundle" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end
directory "/home/vagrant/.vim/bundle/Vundle.vim" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
  action :create
end
git "/home/vagrant/.vim/bundle/Vundle.vim" do
  repository "git://github.com/VundleVim/Vundle.vim.git"
  action :sync
  user "vagrant"
  group "vagrant"
end
cookbook_file "vimrc" do
  path "/home/vagrant/.vimrc"
end
directory "/home/vagrant/.vim/colors" do
  owner "vagrant"
  group "vagrant"
  action :create
  mode "0755"
end
cookbook_file "skeletor.vim" do
  path "/home/vagrant/.vim/colors/skeletor.vim"
end

# Set up latex
package "texlive-base"
package "texlive-latex-base"
package "texlive-latex-recommended"
directory "/home/vagrant/.latex-templates" do
  owner "vagrant"
  group "vagrant"
  action :create
end
cookbook_file "template.tex" do
  path "/home/vagrant/.latex-templates/default-template.tex"
end
