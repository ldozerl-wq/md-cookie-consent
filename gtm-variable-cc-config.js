/*
  ============================================================================
  MD-CC · GTM Variable — "CC Config"
  ----------------------------------------------------------------------------
  Тип переменной: Custom JavaScript
  Имя переменной: CC Config
  ----------------------------------------------------------------------------
  НУЖНО ТОЛЬКО ДЛЯ ЗАПАСНОГО ПУТИ (два тега Custom HTML без хостинга рантайма).

  Основной путь — шаблон тега md-cookie-consent.tpl: там ссылки на политики
  и остальные настройки задаются полями в интерфейсе GTM при добавлении тега,
  и эта переменная не нужна вообще.

  Подключение: в gtm-tag-1-consent-default.html раскомментировать строку
      window.MDCC_CONFIG = {{CC Config}};

  Один контейнер GTM -> много сайтов: добавляете хост в SITES.
  Отдельный контейнер на каждый сайт -> оставьте только ветку DEFAULT.
  ============================================================================
*/
function () {
  var host = location.hostname.replace(/^www\./, '');

  var SITES = {
    'example.md': {
      privacyUrl   : '/ro/politica-de-confidentialitate',
      policyVersion: '1.0',
      revision     : 1,
      defaultLang  : 'ro',
      accent       : '#c0392b',
      buttonBias   : 'accept-first'   // 'equal' — если клиент не готов к риску по deceptive design
    },

    'shop.md': {
      privacyUrl   : '/confidentialitate',
      policyVersion: '1.0',
      revision     : 1,
      defaultLang  : 'ru',
      accent       : '#2b6cb0',
      logEndpoint  : 'https://shop.md/api/consent-log'
    }

    /* добавляйте сайты сюда */
  };

  /* Реквизиты оператора и права субъекта данных в баннере не выводятся —
     они раскрываются в политике конфиденциальности, единственной ссылке баннера. */
  var DEFAULT = {
    privacyUrl   : '/politica-de-confidentialitate',
    policyVersion: '1.0',
    revision     : 1,
    defaultLang  : 'ro',
    autoDetect   : 'document',
    accent       : '#2b6cb0',
    buttonBias   : 'accept-first',
    layout       : 'box wide',
    position     : 'bottom left',
    compactMobile: true,                                      // короткий первый слой RU/EN на телефонах (v10)
    floatingBtn  : true,
    floatingSide : 'left',
    blockPage    : false,
    cookieDays   : 182
  };

  var cfg = SITES[host] || {};
  var out = {};
  var k;
  for (k in DEFAULT) if (DEFAULT.hasOwnProperty(k)) out[k] = DEFAULT[k];
  for (k in cfg)     if (cfg.hasOwnProperty(k))     out[k] = cfg[k];
  return out;
}
