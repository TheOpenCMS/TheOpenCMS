[&larr; Docs](./README.md)

```
```

## Facebook

* https://developers.facebook.com/docs/facebook-login
* https://developers.facebook.com/docs/facebook-login/web
* https://developers.facebook.com/apps/
* Add a New App

  * Display Name: example.com
  * Contact Email: admin@example.com

* Create App ID

* App > Settings > Basic

  * App ID
  * App Secret
  * App Domains: http://theopencms.org
  * Website > Site URL: http://theopencms.org

* Configurate Settings

  ```yaml
  oauth:
    facebook:
      tokens:
        - 100011112222333
        - 1aaaaabbbbbcccccddddddeeeeeeffff
      options:
        scope: 'public_profile,user_friends,email'
        display: popup
  ```

## Debug on local machine

Edit host file

```
sudo vi /etc/hosts
```

Add an instruction at `/etc/hosts`

```
127.0.0.1 theopencms.org
```

Run web server on port number 80

```
rvmsudo rails server -p 80
```
