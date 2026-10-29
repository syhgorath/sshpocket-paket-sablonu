# Changelog

Biçim [Keep a Changelog](https://keepachangelog.com/) esas alınmıştır.

## [Unreleased]

### Eklendi
- `ornekler/betik-paketi/`: `runner: script` örnek paketi (`saglik` salt okunur, `journal_onizle` + `journal_temizle` sudo'lu, önizlemeli, destructive). CI bu klasörü `--strict` doğrular ve betikleri `bash -n` + `shellcheck` ile denetler; `.gitattributes` ve `scripts/release.sh` `ornekler/`'in yayın paketine girmediğini garanti eder.
- README: "Ansible yerine betik mi?" bölümü.

### Değişti
- Vendored doğrulayıcı sshpocket 3.6.2'den 3.6.17 (`cf4255c`) ile senkronlandı: `runner: script` kuralları ve script paketlerinde `scripts/` taraması.

## [0.1.0] - 2026-10-17

### Eklendi
- İlk şablon: salt okunur `bilgi` eylemi (çekirdek, işletim sistemi, çalışma süresi), örnek `ornek_etiket` değişkeni.
