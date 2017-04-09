[&larr; Docs](./README.md)

```
```

## Deploy

To provide a deployment process TheOpenCMS uses its own simple solution `DeployTool`.

`DeployTool` is a simple, procedure-oriented ruby script which does almost the same actions `Capistrano` deployment tool does.

* Why don't I use `Capistrano`? There are some reasons, it's not a good time and place to discuss it. The main reason it's really difficult to debug and maintain all parts of deployment tool which was build with `Capistrano`.
* Why don't I use `Chef`? `Chef` is an obvious overkill for the current project.
* Why don't I use `Ansible`? `Ansible` Looks fine to me, but I didn't use it before. I don't have enough time to figure out how it works and how to use it for the project right now.

### How to setup a server?

[There are some docs](https://github.com/DeployRB/SetupServer#digital-ocean) how to setup your own server on DigitalOcean.

### How to deploy the project?

1. Go to a folder with `DeployTool`

    `cd TheOpenCMS/DeployTool/`

2. Install gems

    `bundle install`

3. Copy templates & config files from examples

    ```
    cp -Rv __TEMPLATES__/production.example __TEMPLATES__/production

    cp -Rv __ENV__/production.example __ENV__/production
    ```

4. Carefully edit the following important configuration files

* DeployTool configuration files

  * `__ENV__/production/server_access.yml`
  * `__ENV__/production/database.yml`
  * `__ENV__/production/deploy_params.yml`

* Application configuration files

  * `__TEMPLATES__/production/settings/app.yml`
  * `__TEMPLATES__/production/settings/app_mailer.yml`
  * `__TEMPLATES__/production/settings/oauth.yml`
  * `__TEMPLATES__/production/settings/devise.yml`
