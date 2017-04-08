[&larr; Docs](./README.md)

```
```

## Facebook

* https://developers.facebook.com/docs/facebook-login
* https://developers.facebook.com/docs/facebook-login/web
* https://developers.facebook.com/apps
* Add a New App

  * Display Name: example.com
  * Contact Email: admin@example.com

* Create App ID

* App > Settings > Basic

  * App ID
  * App Secret
  * App Domains: http://theopencms.org
  * Website > Site URL: http://theopencms.org

#### Application Settings

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

## Twitter

* https://dev.twitter.com
* https://apps.twitter.com
* Create New App

  * Name: example.com
  * Description: example.com
  * Website: http://example.com
  * Callback URL: http://example.com/auth/twitter

* Keys and Access Tokens(active tab)

  * Consumer Key (API Key)
  * Consumer Secret (API Secret)

#### Application Settings

```yaml
oauth:
  twitter:
    tokens:
      - xxxYYYXXXZZZaaaBB
      - xxxYYYXXXZZZaaaBBxxxYYYXXXZZZaaaBBxxxYYYXXXZZZaaaBB
```

## Google Plus

* https://developers.google.com
* Google API Console: https://console.developers.google.com
* Create Project

  * Project name: example-com

* Library > Google APIs

  * Google Apps APIs > Contacts API > [Enable]
  * Social APIs > Google+ API > [Enable]

* Library > Credential

  * OAuth consent screen

    * Product name: example.com
    * Homepage URL: http://example.com

  * Create credentials > OAuth Client ID

    * Web application
    * Name: example.com
    * Authorised JavaScript origins: http://example.com
    * Authorised redirect URIs: http://example.com/auth/google_oauth2/callback

* Client ID / Client Secret

#### Application Settings

```yaml
oauth:
  google_oauth2:
    tokens:
      - 012345678901-qwertyuiopasdfghjklzxcvbnm.apps.googleusercontent.com
      - AABBCCDDDEE-AAAbbbCCC-AB1
    options:
      scope: 'email, profile, plus.me'
      prompt: select_account
      image_aspect_ratio: square
      image_size: 50
      display: popup
      skip_jwt: true
```

## VK.com

* http://vk.com/dev
* https://vk.com/apps?act=manage
* Create an Application

  * Title: example.com
  * Platform: Website
  * Site address: http://example.com
  * Base domain: example.com
  * Confirmation code (via mobile devise)

* Settings

  * Application ID:	123456789
  * Secure key: AAABbbCCCddDEeEFFF

#### Application Settings

```yaml
oauth:
  vkontakte:
    tokens:
      - 12345678
      - AAABbbCCCddDEeEFFF
    options:
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
