#!/usr/bin/env bash
# journal_temizle.sh [--dry-run]: SSHPOCKET_VAR_JOURNAL_GUN günden eski journal kayıtlarını siler (root olarak çalışır).
# --dry-run: yalnızca boyutu gösterir, hiçbir şey silmez.
set -u
gun="${SSHPOCKET_VAR_JOURNAL_GUN:-30}"
[[ "$gun" =~ ^[0-9]{1,4}$ ]] || { echo "journal_gun geçersiz: $gun" >&2; exit 2; }
mb() { journalctl --disk-usage 2>/dev/null | grep -oE '[0-9.]+[KMGT]' | head -n 1 | tr -cd 'A-Za-z0-9.' ; }
before=$(mb)
if [ "${1:-}" = "--dry-run" ]; then
    echo "ÖNİZLEME: ${gun} günden eski journal kayıtları silinecekti (şu an: ${before:-?}); hiçbir şey silinmedi."
    echo "SSHPOCKET_RESULT ornek-betik.journal_onizle journal_boyut=${before:-0} gun=$gun"
    exit 0
fi
journalctl --vacuum-time="${gun}d"
echo "Temizlik tamam (önce: ${before:-?}, sonra: $(mb))."
