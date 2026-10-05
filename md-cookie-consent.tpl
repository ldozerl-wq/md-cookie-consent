___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "MD Cookie Consent (Legea 195/2024)",
  "categories": ["UTILITY", "PERSONALIZATION"],
  "description": "Универсальный cookie-баннер для сайтов Молдовы: Consent Mode v2, 4 категории, RO/RU/EN, журнал согласий. Ссылка на политику задаётся полем ниже — отдельно для каждого проекта.",
  "containerContexts": ["WEB"]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "groupPolicies",
    "displayName": "Ссылка на политику (обязательно)",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "privacyUrl",
        "displayName": "Политика конфиденциальности",
        "simpleValueType": true,
        "help": "URL политики конфиденциальности на этом сайте. Можно относительный (/politica-de-confidentialitate) или полный. Единственная ссылка баннера: именно здесь раскрываются реквизиты оператора, права субъекта данных и порядок обращения в CNPDCP. Отдельная страница политики cookie по закону остаётся обязательной — давайте ссылку на неё из политики конфиденциальности. Страница должна существовать на каждом языке витрины: битая ссылка означает, что требование фактически не выполнено.",
        "valueValidators": [
          { "type": "NON_EMPTY" }
        ],
        "valueHint": "/politica-de-confidentialitate"
      },
      {
        "type": "TEXT",
        "name": "policyVersion",
        "displayName": "Версия политики",
        "simpleValueType": true,
        "defaultValue": "1.0",
        "help": "Записывается в журнал согласий. Позволяет доказать, с какой редакцией политики согласился пользователь."
      },
      {
        "type": "TEXT",
        "name": "revision",
        "displayName": "Ревизия согласия",
        "simpleValueType": true,
        "defaultValue": "1",
        "help": "Увеличьте на 1 при существенном изменении политики — баннер запросит согласие заново у всех, кто уже соглашался.",
        "valueValidators": [
          { "type": "POSITIVE_NUMBER" }
        ]
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupLang",
    "displayName": "Язык",
    "groupStyle": "ZIPPY_OPEN",
    "subParams": [
      {
        "type": "SELECT",
        "name": "defaultLang",
        "displayName": "Язык по умолчанию",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "ro", "displayValue": "Română" },
          { "value": "ru", "displayValue": "Русский" },
          { "value": "en", "displayValue": "English" }
        ],
        "simpleValueType": true,
        "defaultValue": "ro"
      },
      {
        "type": "SELECT",
        "name": "autoDetect",
        "displayName": "Определять язык автоматически",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "document", "displayValue": "По атрибуту <html lang> (рекомендуется)" },
          { "value": "path", "displayValue": "По префиксу адреса: /ro/, /ru/, /en/ — если <html lang> на сайте неверный" },
          { "value": "browser", "displayValue": "По языку браузера" },
          { "value": "false", "displayValue": "Не определять — всегда язык по умолчанию" }
        ],
        "simpleValueType": true,
        "defaultValue": "document",
        "help": "Для многоязычных витрин оставьте «По атрибуту <html lang>» и следите, чтобы шаблон сайта проставлял корректный lang. Коды с регионом (ru-RU, ro-MD) работают, mo и md трактуются как румынский. Если шаблон сайта отдаёт один и тот же lang на всех языковых версиях и починить его нельзя — переключитесь на «По префиксу адреса»: язык берётся из первого сегмента URL, а язык корня задаётся полем «Язык по умолчанию»."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupLook",
    "displayName": "Внешний вид",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "accent",
        "displayName": "Акцентный цвет",
        "simpleValueType": true,
        "defaultValue": "#2b6cb0",
        "help": "HEX-цвет кнопки «Принять все», тумблеров и плавающей кнопки."
      },
      {
        "type": "SELECT",
        "name": "layout",
        "displayName": "Форма баннера",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "box wide", "displayValue": "Карточка, широкие кнопки" },
          { "value": "box", "displayValue": "Карточка, компактная" },
          { "value": "cloud", "displayValue": "Облако" },
          { "value": "bar", "displayValue": "Полоса во всю ширину" }
        ],
        "simpleValueType": true,
        "defaultValue": "box wide"
      },
      {
        "type": "SELECT",
        "name": "position",
        "displayName": "Положение",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "bottom left", "displayValue": "Снизу слева" },
          { "value": "bottom center", "displayValue": "Снизу по центру" },
          { "value": "bottom right", "displayValue": "Снизу справа" },
          { "value": "middle center", "displayValue": "По центру экрана" }
        ],
        "simpleValueType": true,
        "defaultValue": "bottom left"
      },
      {
        "type": "SELECT",
        "name": "buttonBias",
        "displayName": "Вес кнопок",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "stacked", "displayValue": "Столбиком: Принять / Отклонить одного веса, Настроить серая (рекомендуется)" },
          { "value": "accept-first", "displayValue": "Акцент на согласии — выше конверсия, есть правовой риск" },
          { "value": "equal", "displayValue": "Равнозначные в один ряд" }
        ],
        "simpleValueType": true,
        "defaultValue": "stacked",
        "help": "«Столбиком» — три кнопки во всю ширину: Принять все, под ней такая же Отклонить все, ниже серая Настроить. Отказ ровно так же доступен, как согласие, приглушена настройка — это требованиям не противоречит. «Акцент на согласии» красит серым сам отказ: доля согласий выше, но непропорциональное выделение трактуется EDPB Guidelines 03/2022 как deceptive design, и при проверке CNPDCP собранные согласия могут быть признаны недействительными. Выбирайте осознанно и по каждому проекту отдельно."
      },
      {
        "type": "CHECKBOX",
        "name": "floatingBtn",
        "checkboxText": "Плавающая кнопка «Настройки cookie»",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "Постоянная точка отзыва согласия. Снимите галочку, только если добавите в футер сайта свою ссылку с атрибутом data-cc=\"show-preferencesModal\" — без одного из двух отзыв согласия недоступен, а это требование закона."
      },
      {
        "type": "SELECT",
        "name": "floatingSide",
        "displayName": "Сторона плавающей кнопки",
        "macrosInSelect": false,
        "selectItems": [
          { "value": "left", "displayValue": "Слева" },
          { "value": "right", "displayValue": "Справа" }
        ],
        "simpleValueType": true,
        "defaultValue": "left",
        "enablingConditions": [
          { "paramName": "floatingBtn", "paramValue": true, "type": "EQUALS" }
        ],
        "help": "Справа обычно висит виджет чата — по умолчанию слева."
      },
      {
        "type": "CHECKBOX",
        "name": "blockPage",
        "checkboxText": "Блокировать страницу до выбора",
        "simpleValueType": true,
        "defaultValue": false,
        "help": "Затемняет страницу и блокирует прокрутку, пока пользователь не сделает выбор. Повышает долю ответов, но ухудшает поведенческие метрики."
      },
      {
        "type": "CHECKBOX",
        "name": "compactMobile",
        "checkboxText": "Компактный баннер на телефонах",
        "simpleValueType": true,
        "defaultValue": true,
        "help": "RU и EN: на экранах до 640px первый слой показывает короткую фразу и ссылку «Подробнее» вместо длинного абзаца. Длинный абзац появляется поздно (после GTM) и на телефоне оказывается самым крупным текстом экрана — PageSpeed засчитывает его как LCP и занижает оценку. Полный текст, настройки и политика остаются в одно нажатие."
      }
    ]
  },
  {
    "type": "GROUP",
    "name": "groupAdvanced",
    "displayName": "Дополнительно",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "cookieDays",
        "displayName": "Срок хранения согласия, дней",
        "simpleValueType": true,
        "defaultValue": "182",
        "help": "Не более 365. По практике надзорных органов согласие переспрашивают раз в 6–12 месяцев.",
        "valueValidators": [
          { "type": "POSITIVE_NUMBER" }
        ]
      },
      {
        "type": "TEXT",
        "name": "logEndpoint",
        "displayName": "URL серверного журнала согласий",
        "simpleValueType": true,
        "help": "Необязательно. Если указать, на этот адрес уйдёт POST application/json с записью согласия. Локального журнала в браузере для доказательства перед CNPDCP недостаточно — пользователь может его очистить.",
        "valueHint": "https://example.md/api/consent-log"
      },
      {
        "type": "TEXT",
        "name": "runtimeUrl",
        "displayName": "URL файла md-cookie-consent.js",
        "simpleValueType": true,
        "defaultValue": "https://cdn.jsdelivr.net/gh/ldozerl-wq/md-cookie-consent@v11/md-cookie-consent.js",
        "help": "Куда вы выложили рантайм баннера. Один файл обслуживает все проекты. Домен должен быть разрешён в правах шаблона (вкладка Permissions → Injects scripts).",
        "valueValidators": [
          { "type": "NON_EMPTY" }
        ]
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const injectScript = require('injectScript');
const setInWindow = require('setInWindow');
const setDefaultConsentState = require('setDefaultConsentState');
const updateConsentState = require('updateConsentState');
const gtagSet = require('gtagSet');
const getCookieValues = require('getCookieValues');
const JSON = require('JSON');
const log = require('logToConsole');

/* ---------------------------------------------------------------------------
   1. Consent Mode v2 — запрещаем всё до согласия.
      Тег должен стоять на триггере Consent Initialization – All Pages,
      иначе GA4 успеет отправить хит раньше.
   --------------------------------------------------------------------------- */

setDefaultConsentState({
  ad_storage: 'denied',
  ad_user_data: 'denied',
  ad_personalization: 'denied',
  analytics_storage: 'denied',
  functionality_storage: 'denied',
  personalization_storage: 'denied',
  security_storage: 'granted',
  wait_for_update: 500
});

gtagSet({
  ads_data_redaction: true,
  url_passthrough: true
});

/* ---------------------------------------------------------------------------
   2. Вернувшийся пользователь: поднимаем сохранённый выбор из cookie сразу,
      не дожидаясь загрузки баннера — иначе теряем 500 мс на каждом хите.
   --------------------------------------------------------------------------- */

const raw = getCookieValues('cc_cookie');

if (raw && raw.length > 0) {
  const stored = JSON.parse(raw[0]);

  if (stored && stored.categories) {
    const cats = stored.categories;
    const functional = cats.indexOf('functional') > -1;
    const analytics = cats.indexOf('analytics') > -1;
    const marketing = cats.indexOf('marketing') > -1;

    updateConsentState({
      ad_storage: marketing ? 'granted' : 'denied',
      ad_user_data: marketing ? 'granted' : 'denied',
      ad_personalization: marketing ? 'granted' : 'denied',
      analytics_storage: analytics ? 'granted' : 'denied',
      functionality_storage: functional ? 'granted' : 'denied',
      personalization_storage: functional ? 'granted' : 'denied',
      security_storage: 'granted'
    });
  }
}

/* ---------------------------------------------------------------------------
   3. Настройки из полей тега -> window.MDCC_CONFIG, затем подгружаем рантайм.
      Песочница GTM не имеет доступа к DOM, поэтому вся отрисовка баннера
      живёт в отдельном файле md-cookie-consent.js.
   --------------------------------------------------------------------------- */

setInWindow('MDCC_CONFIG', {
  privacyUrl: data.privacyUrl,
  policyVersion: data.policyVersion,
  revision: data.revision,
  defaultLang: data.defaultLang,
  autoDetect: data.autoDetect,
  accent: data.accent,
  layout: data.layout,
  position: data.position,
  buttonBias: data.buttonBias,
  floatingBtn: data.floatingBtn,
  compactMobile: data.compactMobile,
  floatingSide: data.floatingSide,
  blockPage: data.blockPage,
  cookieDays: data.cookieDays,
  logEndpoint: data.logEndpoint
}, true);

const onFailure = () => {
  log('MD Cookie Consent: не удалось загрузить ' + data.runtimeUrl +
      '. Баннер не показан, согласие не собирается — проверьте URL рантайма ' +
      'и разрешённые домены во вкладке Permissions.');
  data.gtmOnFailure();
};

injectScript(data.runtimeUrl, data.gtmOnSuccess, onFailure, 'mdcc_runtime');


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://cdn.jsdelivr.net/"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "key" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" },
                  { "type": 1, "string": "execute" }
                ],
                "mapValue": [
                  { "type": 1, "string": "MDCC_CONFIG" },
                  { "type": 8, "boolean": true },
                  { "type": 8, "boolean": true },
                  { "type": 8, "boolean": false }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "consentType" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" }
                ],
                "mapValue": [
                  { "type": 1, "string": "ad_storage" },
                  { "type": 8, "boolean": false },
                  { "type": 8, "boolean": true }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "consentType" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" }
                ],
                "mapValue": [
                  { "type": 1, "string": "ad_user_data" },
                  { "type": 8, "boolean": false },
                  { "type": 8, "boolean": true }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "consentType" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" }
                ],
                "mapValue": [
                  { "type": 1, "string": "ad_personalization" },
                  { "type": 8, "boolean": false },
                  { "type": 8, "boolean": true }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "consentType" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" }
                ],
                "mapValue": [
                  { "type": 1, "string": "analytics_storage" },
                  { "type": 8, "boolean": false },
                  { "type": 8, "boolean": true }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "consentType" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" }
                ],
                "mapValue": [
                  { "type": 1, "string": "functionality_storage" },
                  { "type": 8, "boolean": false },
                  { "type": 8, "boolean": true }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "consentType" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" }
                ],
                "mapValue": [
                  { "type": 1, "string": "personalization_storage" },
                  { "type": 8, "boolean": false },
                  { "type": 8, "boolean": true }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  { "type": 1, "string": "consentType" },
                  { "type": 1, "string": "read" },
                  { "type": 1, "string": "write" }
                ],
                "mapValue": [
                  { "type": 1, "string": "security_storage" },
                  { "type": 8, "boolean": false },
                  { "type": 8, "boolean": true }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "cc_cookie"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "write_data_layer",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "ads_data_redaction"
              },
              {
                "type": 1,
                "string": "url_passthrough"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

MD Cookie Consent — шаблон тега для Google Tag Manager.

Триггер: Consent Initialization – All Pages. Приоритет: 1000.
Тег ставит Consent Mode v2 в denied, восстанавливает сохранённый выбор
из cookie cc_cookie и подгружает рантайм баннера md-cookie-consent.js.

Если вы выложили рантайм не на jsDelivr, откройте вкладку Permissions
и добавьте свой домен в Injects scripts.
