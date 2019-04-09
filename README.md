# Vagrant Box for PHP 5.3 with Apache 2.2, Mysql 5.5 and Mongo 3.2 on Ubuntu 12

## Version List

- Ubuntu 12
- PHP 5.3
- Apache/2.2.22
- Mysql 5.5.54 (User: root | Password: root)
- Mongo 3.2.10
- Composer 1.8.0 
- Pecl List
  + APC         3.1.13 
  + apcu        4.0.10 
  + memcache    2.2.7  
  + memcached   2.2.0  
  + mongo       1.6.14 
  + zendopcache 7.0.5  

## Usage

1) Define host.

```sh
 192.168.10.10 app.local
```

> If you need HTTPS, use [mkcert](https://github.com/FiloSottile/mkcert)

2) Define `local-project-path` in `Vagrantfile` as your project absolute path.

```sh
# Project path
config.vm.synced_folder "local-project-path", "/var/www/app/"
```

3) Run box.
```sh
vagrant up
```

5) You can use phpMyAdmin via http://app.local/phpmyadmin

## Troubleshooting

1) If you get an error like this. 

```sh
mount: unknown filesystem type 'vboxsf'
```

Install `vagrant-vbguest`.

```sh
vagrant plugin install vagrant-vbguest
vagrant destroy && vagrant up
```
