Set up with

```bash
cd fake_production
vagrant up
vagrant ssh-config > ../safe/ssh_configuration
cd -
kerek provision
```

Keep running with

```bash
kerek run
```

Tear down with

```bash
cd fake_production
vagrant destroy
cd -
kerek clean
```
