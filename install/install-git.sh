#!/bin/bash

echo 'Installing git config...'

rm $HOME/$ROOT_CONFIG/git/gitconfig >/dev/null
cp $HOME/$ROOT_CONFIG/git/gitconfig_template $HOME/$ROOT_CONFIG/git/gitconfig

if [ -z "$GIT_EMAIL" ]
  then
    echo "Git config - Please enter your email address \n"
    echo "> "
    read GIT_EMAIL
    echo "GIT_EMAIL=$GIT_EMAIL" >> $HOME/$ROOT_CONFIG/install_config
fi

sed -i -e "s/<email>/${GIT_EMAIL}/g" $HOME/$ROOT_CONFIG/git/gitconfig

if [ -z "$GIT_USER" ]
  then
    echo "Git config - Please enter your name \n"
    echo "> "
    read GIT_USER
    echo "GIT_USER=$GIT_USER" >> $HOME/$ROOT_CONFIG/install_config
fi

sed -i -e "s/<name>/${GIT_USER}/g" $HOME/$ROOT_CONFIG/git/gitconfig

echo "Create symlink for gitconfig and global gitignore... \n"

ln -s -f $HOME/$ROOT_CONFIG/git/gitconfig $HOME/.gitconfig
ln -s -f $HOME/$ROOT_CONFIG/git/gitignore $HOME/.gitignore

echo "Set the global hooks - the hooks will be created each time a project is cloned"

git config --global init.templatedir "$HOME/$ROOT_CONFIG/git/templates"
