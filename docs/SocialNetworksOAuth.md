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
