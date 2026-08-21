# MD Cookie Consent — универсальный GDPR-баннер для сайтов Молдовы

Готовый к тиражированию комплект для Google Tag Manager на базе
[vanilla-cookieconsent v3.1.0](https://cookieconsent.orestbida.com/) (MIT).
Собственный **шаблон тега GTM**: подключение нового проекта — импортировать шаблон,
добавить тег и вписать в поля две ссылки на политики. Ни строки кода на проект.

**Правовая база:** Закон РМ №195/2024 о защите персональных данных (в силе с **23.08.2026**,
штрафы до **2 000 000 леев или 2% годового оборота**) + Закон №284/2004 об услугах
информационного общества (именно он регулирует cookie) + Consent Mode v2 как требование Google.
Надзорный орган — **CNPDCP** (datepersonale.md).

---

## Что внутри

| Файл | Назначение |
|---|---|
| **`md-cookie-consent.tpl`** | **Шаблон тега GTM** — поля настроек в интерфейсе, Consent Mode v2, загрузка рантайма |
| **`md-cookie-consent.js`** | **Рантайм баннера** — исходник и единственное место правок. Выкладывается на CDN, один файл на все проекты |
| `cookie-policy-template.md` | Шаблон страницы «Политика Cookie» на RO/RU/EN |
| `test.html` | Локальный стенд: проверяет и путь шаблона, и inline-путь |
| `build.ps1` | Пересобирает inline-тег из рантайма |
| `gtm-tag-1-consent-default.html` | Запасной путь без хостинга: Consent Mode default (Custom HTML) |
| `gtm-tag-2-banner.html` | Запасной путь без хостинга: баннер (Custom HTML). **Генерируется**, не редактировать |
| `gtm-variable-cc-config.js` | Запасной путь: переменная `{{CC Config}}` — реестр сайтов по домену |

> `gtm-tag-2-banner.html` собирается из `md-cookie-consent.js` командой
> `powershell -File build.ps1`. Правки вносятся только в `.js`, иначе две копии разъедутся.

---

## Установка — шаблон тега (основной путь)

### Шаг 0. Один раз: выложить рантайм

Шаблон работает в песочнице GTM без доступа к DOM, поэтому отрисовка баннера живёт
в отдельном файле. **Один файл обслуживает все проекты** — выложите его один раз.

**Уже сделано** — рантайм лежит в [github.com/ldozerl-wq/md-cookie-consent](https://github.com/ldozerl-wq/md-cookie-consent)
и раздаётся через jsDelivr:

```
https://cdn.jsdelivr.net/gh/ldozerl-wq/md-cookie-consent@v1/md-cookie-consent.js
```

Этот URL уже стоит в шаблоне значением по умолчанию — поле трогать не нужно.

Тег `@v1` фиксирует версию: правки в репозитории не поедут на прод сами по себе.
Обновление — новый тег `v2` и смена URL в поле шаблона.

**Вариант со своим доменом:** положите файл рядом с сайтом
(`https://ваш-домен.md/assets/md-cookie-consent.js`) и добавьте этот домен
в правах шаблона: **Templates → ваш шаблон → Permissions → Injects scripts**.

### Шаг 1. Импорт шаблона в контейнер

**Templates → Tag Templates → New → ⋮ → Import** → выбрать `md-cookie-consent.tpl` → **Save**.

Повторяется для каждого контейнера. Дальше шаблон живёт внутри контейнера и обновлять
его нужно только при выходе новой версии.

### Шаг 2. Добавить тег и заполнить поля

**Tags → New → Tag Configuration → MD Cookie Consent (Legea 195/2024)**

| Параметр | Значение |
|---|---|
| Name | `Cookie Consent (MD)` |
| **Политика Cookie** | `/politica-cookie` — ссылка для этого проекта |
| **Политика конфиденциальности** | `/politica-de-confidentialitate` — ссылка для этого проекта |
| URL файла `md-cookie-consent.js` | адрес из шага 0 |
| Advanced → Tag firing priority | `1000` |
| Advanced → Consent Settings | **No additional consent required** |
| Trigger | **Consent Initialization – All Pages** |

> Именно `Consent Initialization`, а не `All Pages` — иначе GA4 успеет отправить хит
> до установки Consent Mode в `denied`.

Остальные поля (язык, цвет, форма баннера, вес кнопок, срок хранения, журнал согласий)
имеют рабочие значения по умолчанию — трогать их не обязательно.

**Всё. Подключение следующего проекта = шаги 1–2, две ссылки в поля.**

### Шаг 3. Заблокировать существующие теги

Два способа, можно комбинировать.

**А. Встроенные Consent Checks (рекомендуется для Google-тегов).**
Открыть тег → Advanced Settings → Consent Settings → *Require additional consent for tag to fire*:

| Тег | Требуемое согласие |
|---|---|
| GA4 Configuration / Events | `analytics_storage` |
| Google Ads Conversion / Remarketing | `ad_storage`, `ad_user_data`, `ad_personalization` |
| Floodlight | `ad_storage`, `ad_user_data` |
| Meta Pixel, TikTok, LinkedIn Insight | `ad_storage`, `ad_user_data`, `ad_personalization` |
| Hotjar, Clarity, Yandex.Metrica | `analytics_storage` |
| YouTube-эмбеды, чаты, карты | `functionality_storage` |

**Б. Триггеры по событиям (для не-Google тегов и Custom HTML).**
Рантайм пушит в dataLayer:

| Событие | Когда |
|---|---|
| `cookie_consent_update` | при любом выборе + при восстановлении сохранённого |
| `cc_analytics_granted` | согласие на аналитику |
| `cc_marketing_granted` | согласие на маркетинг |
| `cc_functional_granted` | согласие на функциональные |

Создать триггер *Custom Event* → `cc_marketing_granted` и повесить на Meta Pixel и т.п.

Дополнительно доступны переменные dataLayer:
`consent_id`, `consent_timestamp`, `consent_language`, `consent_revision`,
`consent_policy_version`, `consent_action`, `consent_necessary`, `consent_functional`,
`consent_analytics`, `consent_marketing`, `consent_source`.

### Шаг 4. Скрипты вне GTM

Всё, что вставлено прямо в шаблон сайта, тоже должно ждать согласия:

```html
<script type="text/plain" data-category="analytics" src="https://example.com/analytics.js"></script>

<script type="text/plain" data-category="marketing">
  /* код пикселя */
</script>

<iframe data-category="functional" data-src="https://www.youtube.com/embed/XXXX"></iframe>
```

`type="text/plain"` обязателен — без него браузер выполнит скрипт до согласия.

### Шаг 5. Ссылка «Настройки cookie» в футере

Плавающая кнопка включена галочкой в шаблоне. Если хотите вместо неё обычную ссылку
в футере — снимите галочку «Плавающая кнопка» и добавьте на сайт:

```html
<a href="#" data-cc="show-preferencesModal">Setări cookie</a>
```

Атрибут `data-cc` работает на любом элементе, JS писать не нужно.
Одно из двух должно быть обязательно: без постоянной точки отзыва согласия
требование закона не выполняется.

---

## Установка без хостинга (запасной путь)

Если выложить `md-cookie-consent.js` некуда, тот же баннер ставится двумя тегами
Custom HTML. Минус: настройки задаются не полями, а переменной GTM.

1. **Variables → New → Custom JavaScript**, имя `CC Config` — содержимое
   `gtm-variable-cc-config.js`, заполнить блок `SITES` доменами проектов.
2. **Tags → New → Custom HTML**, `gtm-tag-1-consent-default.html`,
   приоритет `1000`, триггер **Consent Initialization – All Pages**.
   В начале тега раскомментировать `window.MDCC_CONFIG = {{CC Config}};`.
3. **Tags → New → Custom HTML**, `gtm-tag-2-banner.html`,
   приоритет `900`, триггер **Initialization – All Pages**.

Дальше — шаги 3–5 выше, они одинаковы для обоих путей.

---

## Настройки на сайт

При основном пути — поля шаблона в интерфейсе GTM. При запасном — ключи в `SITES`
внутри `{{CC Config}}` или `window.MDCC_CONFIG` на самом сайте. Названия совпадают.

| Ключ | По умолчанию | Описание |
|---|---|---|
| `privacyUrl` | `/politica-de-confidentialitate` | Ссылка на политику конфиденциальности |
| `cookieUrl` | `/politica-cookie` | Ссылка на отдельную политику cookie |
| `policyVersion` | `'1.0'` | Версия политики — пишется в журнал согласий |
| `revision` | `1` | **++ при изменении политики** → у всех запрашивается согласие заново |
| `defaultLang` | `'ro'` | `ro` / `ru` / `en` |
| `autoDetect` | `'document'` | `document` (по `<html lang>`), `browser`, или `false` |
| `layout` | `'box wide'` | `box`, `box wide`, `box inline`, `cloud`, `bar`, `bar inline` |
| `position` | `'bottom left'` | Положение баннера |
| `accent` | `#2b6cb0` | Цвет главной кнопки и тумблеров |
| `buttonBias` | `'accept-first'` | `accept-first` — «Принять все» акцентная, «Отклонить все» серая рядом с ней, «Настроить» у правого края. `equal` — все кнопки одного веса. См. предупреждение ниже |
| `floatingBtn` | `true` | Плавающая кнопка отзыва согласия |
| `floatingSide` | `'left'` | `left` / `right` (справа обычно чат — лучше слева) |
| `blockPage` | `false` | `true` = блокировать взаимодействие со страницей до выбора |
| `cookieDays` | `182` | Срок хранения согласия, дней (не более 12 мес.) |
| `logEndpoint` | `''` | URL для серверного журнала согласий (POST JSON) |
| `cdnBase` | jsDelivr | Заменить при самохостинге библиотеки |

### `buttonBias` — визуальный вес кнопок

По умолчанию стоит **`accept-first`**: на первом слое ряд выглядит так —

```
[ Принять все ] [ Отклонить все ]  ················  [ Настроить ]
    акцентная         серая                            обычная
```

На мобильном ряд превращается в столбец, порядок сохраняется: принять → отклонить → настроить.

Это родной порядок узлов CookieConsent — DOM не модифицируется, обход по Tab совпадает
с визуальным порядком без дополнительных ухищрений.

> ⚠️ **Правовой риск.** Непропорциональное выделение кнопки согласия — это deceptive design
> по EDPB Guidelines 03/2022 (раздел о «highlighting» и «visual interference»). Требование
> «отказаться не сложнее, чем согласиться» формально нарушается не порядком кнопок,
> а разницей в цветовом контрасте. При проверке CNPDCP согласие, собранное таким баннером,
> может быть признано недействительным со всеми последствиями — включая штраф
> до 2 000 000 леев или 2% годового оборота и обязанность удалить собранные данные.
>
> Порядок «принять слева, отказаться справа» сам по себе законен. Рискует именно серый цвет.
>
> Для клиентов, где такой риск неприемлем, ставьте в `{{CC Config}}`:
> ```js
> buttonBias: 'equal'
> ```
> Это вернёт `equalWeightButtons: true` и одинаковое оформление всех кнопок.
> Решение принимается по каждому сайту отдельно — переключатель для того и сделан.

### Многоязычные сайты

Ставьте корректный `<html lang="ro">` / `lang="ru"` — при `autoDetect: 'document'`
баннер сам подхватит язык страницы. `lang="mo"` и `lang="md"` мапятся на румынский.

---

## Журнал согласий

Требование закона: каждое действие фиксируется отдельной записью с меткой времени,
языком, выбранными категориями и версией политики; записи не перезаписываются.

**Клиентская сторона** — `localStorage.mdcc_consent_log`, до 50 последних записей:

```js
MDCC.log()
// [{id, ts, lang, rev, pv, act, cats, url}, ...]
```

**Серверная сторона** — задайте `logEndpoint`, и на него уйдёт `POST application/json`
(через `sendBeacon`) с полями `consent_id`, `timestamp`, `language`, `revision`,
`policy_version`, `action`, `categories`, `page`, `user_agent`.

> Для полноценного доказательства согласия при проверке CNPDCP серверный журнал
> обязателен — localStorage пользователь может очистить. Храните записи столько же,
> сколько действует согласие, + срок исковой давности.

---

## Публичный API на странице

```js
MDCC.show()              // открыть настройки
MDCC.reset()             // стереть согласие и перезагрузить (для тестов)
MDCC.log()               // журнал согласий
MDCC.accepted('marketing') // true/false

CookieConsent.setLanguage('ru')
CookieConsent.acceptedCategory('analytics')
CookieConsent.showPreferences()
```

---

## Соответствие требованиям

| Требование | Как закрыто |
|---|---|
| Скрипты не грузятся до согласия | `mode: 'opt-in'` + `manageScriptTags` + Consent Mode `denied` в Теге 1 |
| Три кнопки на первом экране | `Accept toate` / `Refuz toate` / `Setări` — все три видны без прокрутки и без доп. кликов |
| «Отказаться не сложнее, чем согласиться» | ⚠️ **Частично.** Отказ — один клик, кнопка стоит вплотную к «Принять все», но при `buttonBias: 'accept-first'` (по умолчанию) она серая. Полное соответствие — `buttonBias: 'equal'`, см. раздел выше |
| 4 категории | necessary (readOnly) / functional / analytics / marketing |
| Гранулярность | Отдельный тумблер на каждую необязательную категорию |
| Нет преднажатых галочек | `enabled: false` у всех необязательных категорий |
| Отзыв согласия в любой момент | Плавающая кнопка + `data-cc="show-preferencesModal"` |
| Удаление cookie при отказе | `autoClearCookies: true` + regex-списки по каждой категории |
| Информирование | Модалка настроек: цель, правовое основание, поставщик, срок хранения по каждому cookie |
| Оператор и контакты | ⚠️ **В баннере не выводятся** — только на странице Политики Cookie. Ссылка на неё есть и на первом слое, и в окне настроек |
| Трансграничная передача | Указана в секции «Маркетинг» (стандартные договорные положения) |
| Права субъекта + CNPDCP + 1 месяц | ⚠️ **В баннере не выводятся** — раздел 6 Политики Cookie, все три языка |
| Журнал согласий | `mdcc_consent_log` + `logEndpoint` + `consent_id` + `policy_version` |
| Версионирование политики | `revision` → повышение форсирует пересогласие |
| Все языки витрины | RO / RU / EN, автоопределение по `<html lang>` |
| Отдельная страница Политики Cookie | `cookie-policy-template.md` (нужно опубликовать на каждом языке) |
| Consent Mode v2 | `ad_user_data` + `ad_personalization` + `ads_data_redaction` + `url_passthrough` |

## Что остаётся сделать вручную

1. **Опубликовать страницы** «Политика конфиденциальности» и «Политика Cookie» на каждом языке
   (шаблон — `cookie-policy-template.md`) и вписать их URL в `{{CC Config}}`.
   Это теперь единственное место, где раскрываются реквизиты оператора, права субъекта
   данных и порядок обращения в CNPDCP — в баннере их нет, так что страницы обязательны
   и ссылки в `privacyUrl` / `cookieUrl` должны вести на живые URL, а не на 404.
2. **Сверить таблицы cookie** в Теге 2 с реальным набором на сайте
   (DevTools → Application → Cookies после принятия всех категорий). Лишние строки убрать, недостающие добавить.
3. **Проверить `autoClear`-списки** — добавить cookie ваших сервисов, чтобы отказ реально их стирал.
4. **Заключить DPA** с обработчиками (Google, Meta, хостинг, CRM) и отразить их в политике.
5. **Настроить серверный `logEndpoint`** и хранение журнала.
6. Уведомительные/регистрационные обязанности перед CNPDCP — по профилю обработки; вопрос к юристу.

> Комплект закрывает техническую часть. Юридическую оценку конкретной обработки
> (правовые основания, DPIA, назначение DPO, регистрация) он не заменяет.

---

## Тестирование

```bash
python -m http.server 8777 --directory md-cookie-consent
```

Стенд показывает состояние Consent Mode, категории, события dataLayer, журнал согласий
и скрипт, заблокированный до согласия на аналитику.

| URL | Что проверяет |
|---|---|
| `http://localhost:8777/test.html` | Основной путь: `MDCC_CONFIG` со строковыми значениями (как их отдаёт шаблон GTM) + рантайм отдельным файлом |
| `…/test.html?cdn=1` | Продовый путь целиком: рантайм тянется с jsDelivr по тому же URL, что стоит в шаблоне |
| `…/test.html?inline=1` | Запасной путь: сгенерированный Custom HTML тег |
| `…/test.html?bias=equal` | Вариант с равнозначными кнопками |

Чек-лист перед публикацией:

- [ ] До выбора: в DevTools → Application → Cookies нет `_ga`, `_fbp`, `_gcl_*`
- [ ] «Отклонить все» → cookie не появляются, `analytics_storage: denied` в GA4 debug
- [ ] «Принять все» → теги срабатывают, в Tag Assistant виден `consent update`
- [ ] Отказ после согласия → старые cookie удаляются (`autoClear`)
- [ ] Плавающая кнопка открывает настройки на всех языках
- [ ] `<html lang>` меняет язык баннера
- [ ] `revision: 2` → баннер показывается заново уже согласившимся
- [ ] Google Tag Assistant → вкладка Consent: все 7 сигналов присутствуют
- [ ] Preview-режим GTM: тег шаблона сработал на Consent Initialization, ошибок в консоли нет
- [ ] Ссылки из полей тега открываются, а не ведут на 404

---

## Обновление версии

Рантайм зафиксирован тегом в URL (`@v1`), поэтому правки в репозитории не уезжают
на прод сами. Порядок обновления:

1. Правки — только в `md-cookie-consent.js`.
2. `powershell -File build.ps1` — пересобрать inline-тег.
3. Новый тег в репозитории (`v2`).
4. В контейнерах поменять URL в поле «URL файла md-cookie-consent.js».

Шаблон `.tpl` переимпортируется только если менялись поля или код песочницы.

---

## Самохостинг библиотеки cookieconsent

Зависимость от jsDelivr — точка отказа и внешний запрос. Для продакшена скачайте
`cookieconsent.umd.js` и `cookieconsent.css` из
`https://cdn.jsdelivr.net/npm/vanilla-cookieconsent@3.1.0/dist/`, положите рядом
с рантаймом и поменяйте `cdnBase` в `DEFAULTS` внутри `md-cookie-consent.js`
(отдельным полем шаблона это не вынесено — настройка разовая, на все проекты сразу).

Рантайм ничего не грузит до `DOMContentLoaded` и не блокирует рендер (`defer`),
вес — ~30 КБ gzip.
