<#
    Регенерирует gtm-tag-2-banner.html из md-cookie-consent.js.

    md-cookie-consent.js — единственный источник правды. Inline-тег для Custom HTML
    нужен только тем, кто не хочет хостить файл; чтобы две копии не разъезжались,
    он всегда собирается отсюда.

    Запуск:  powershell -File build.ps1
#>

$ErrorActionPreference = 'Stop'
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$src = Join-Path $dir 'md-cookie-consent.js'
$out = Join-Path $dir 'gtm-tag-2-banner.html'

if (-not (Test-Path $src)) { throw "Не найден исходник: $src" }

$header = @'
<!--
  ============================================================================
  MD-CC · Inline-вариант для GTM Custom HTML
  ----------------------------------------------------------------------------
  ФАЙЛ СГЕНЕРИРОВАН. Не редактируйте — правьте md-cookie-consent.js
  и пересоберите:  powershell -File build.ps1
  ----------------------------------------------------------------------------
  Нужен только если вы НЕ хостите md-cookie-consent.js и не используете
  шаблон тега md-cookie-consent.tpl. Рекомендуемый путь — шаблон:
  там ссылки на политики задаются полями в интерфейсе GTM при добавлении тега.

  GTM: Custom HTML tag
  Trigger:  Initialization – All Pages
  Tag firing priority: 900
  Требует Тег 1 (gtm-tag-1-consent-default.html) на Consent Initialization.

  Настройки сайта задаются переменной GTM или на самом сайте:
      window.MDCC_CONFIG = { privacyUrl: '...' };
  ============================================================================
-->
<script>
'@

$footer = '</script>'

$body = Get-Content $src -Encoding UTF8

# отрезаем баннерный комментарий исходника — в inline-теге он лишний
$start = 0
for ($i = 0; $i -lt $body.Count; $i++) {
  if ($body[$i] -match '^\(function') { $start = $i; break }
}

$result = @($header) + $body[$start..($body.Count - 1)] + @($footer)
Set-Content -Path $out -Value $result -Encoding UTF8

Write-Host "OK: $out  ($($result.Count) строк из $src)"
