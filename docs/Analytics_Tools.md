[&larr; Docs](./README.md)

```
```

## Google Analytics

* analytics.google.com/analytics/web/provision
* To track: WebSite
* Account Name: Example.com
* Website Name: Example.com
* Website URL: http://example.com
* Tracking ID: UA-01234567-0
* analytics.google.com/analytics/web/
  * Admin > PROPERTY > Tracking Info > JS > Tracking Code

* Setup an ID in config files

  `config/ENV/[ENVIRONMENT NAME]/settings/services.yml`

  `DeployTool/__TEMPLATES__/[ENVIRONMENT NAME]/settings/services.yml`

  ```yml
  services:
    google_analytics:
      tracking_id: 'UA-01234567-0'
  ```

## Yandex Metrika

* https://metrika.yandex.ru/list
* Add Counter
  * Counter name: Example.com
  * Website address: https://example.com
  * Settings > Common > Counter Number: `01234567`

* Setup an ID in config files

  `config/ENV/[ENVIRONMENT NAME]/settings/services.yml`

  `DeployTool/__TEMPLATES__/[ENVIRONMENT NAME]/settings/services.yml`

  ```yml
  services:
    yandex_metrika:
      tracking_id: '01234567'
  ```
