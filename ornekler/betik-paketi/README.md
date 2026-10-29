# ornek-betik: runner: script örneği

Betik paketinin en küçük çalışan örneği. **Betikler hedef sunucuda çalışır**; kontrol makinesinde (Mac) yabancı kod çalışmaz.

| Eylem | Etki | Sudo | Ne yapar |
|---|---|---|---|
| `saglik` | salt okunur | hayır | disk %, yük, yeniden başlatma gerekli mi (sonuç satırı) |
| `journal_onizle` | salt okunur | evet | journal boyutu ve silinecek yaş |
| `journal_temizle` | **destructive** | evet | `journalctl --vacuum-time`; önizleme + sunucu adıyla onay zorunlu |

Geri alma: silinen journal kayıtları geri getirilemez; `journal_temizle` bu yüzden `destructive` ve önizlemesiz çalışmaz.

Kurallar için: sshpocket `docs/package-standard.md` §7 ("script runner ayrıntıları"). Kısaca:
- `cmd` = `scripts/<ad>.sh [en çok 8 düz argüman]`; `--dry-run` desteği varsa iki eylem tanımlayın (`*_onizle` + gerçek eylem, `requires` ile bağlı).
- Değişkenler betikte `SSHPOCKET_VAR_<AD>` olarak gelir (`journal_gun` → `$SSHPOCKET_VAR_JOURNAL_GUN`); ayrıca `SSHPOCKET_SERVER`, `SSHPOCKET_ACTION`, `SSHPOCKET_PROFILE`. Bağlantı bilgisi (host/anahtar) **verilmez**.
- Sonuç: betik tek satır yazar: `SSHPOCKET_RESULT <paket-id>.<eylem> anahtar=değer …` (anahtarları `outputs.keys` listeler; değerler `[A-Za-z0-9_.:+-]`).
- `requires_sudo` yoksa betik stdin'den akar (stdin okuyamaz); varsa sudo parolası aynı terminalde sudo isteminde girilir ve betik root'a ait kopyadan, SHA-256 doğrulanarak çalışır.
- Betikleri `bash -n` ve `shellcheck` ile denetleyin; CI bunu bu klasör için de çalıştırır.
