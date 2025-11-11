#cloud-config
write_files:
    - content: |    
        system {
            root-authentication {
                encrypted-password "${ENCRYPT_PASSWORD}";
            }
            login {
                user admin {
                    uid 2000;
                    class super-user;
                    authentication {
                        encrypted-password "${ENCRYPT_PASSWORD}";
                    }
                }
                user ansibleuser {
                    full-name Ansible;
                    uid 2001;
                    class super-user;
                    authentication {
                        ssh-rsa "${PUB_SSH_KEY}";
                    }
                }
            }
            services {
                ssh {
                    protocol-version v2;
                }
            }
            management-instance;
        }
        interfaces {
            fxp0 {
                unit 0 {
                    family inet {
                        dhcp;
                    }
                }
            }
        }
      path: /var/tmp/tmp_config
    
runcmd:
    - touch /config/juniper.conf
    - cat /var/tmp/tmp_config >> /config/juniper.conf
