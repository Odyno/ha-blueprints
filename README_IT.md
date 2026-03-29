# Home Assistant Blueprints - Documentazione Italiana

Benvenuto nel repository dei blueprint Home Assistant! Questa è una collezione curata di blueprint affidabili e ben documentati per Home Assistant.

## 🚀 Avvio Veloce (5 minuti)

### Il modo più semplice: Importazione diretta

1. Vai a **Impostazioni → Automazioni e Scene → Blueprint**
2. Clicca il pulsante blu **Importa Blueprint**
3. Clicca il badge di importazione accanto al blueprint che vuoi usare nella pagina principale [README.md](./README.md)
4. Home Assistant farà il resto automaticamente
5. Fatto! ✅

---

## 📚 Documentazione

### Per iniziare
- **[SETUP.md](./docs/SETUP.md)** - Guida completa di installazione e configurazione
- **[README.md](./README.md)** - Elenco completo dei blueprint disponibili (in inglese)

### Approfondimento
- **[BLUEPRINT_GUIDE.md](./docs/BLUEPRINT_GUIDE.md)** - Come funzionano i blueprint e come crearli
- **[FAQ.md](./docs/FAQ.md)** - Domande frequenti e risposte
- **[TROUBLESHOOTING.md](./docs/TROUBLESHOOTING.md)** - Risolvere problemi comuni

### Per sviluppatori
- **[CONTRIBUTING.md](./CONTRIBUTING.md)** - Come contribuire con nuovi blueprint
- **[CHANGELOG.md](./CHANGELOG.md)** - Cronologia delle versioni

---

## 📋 Blueprint Disponibili

### Automazioni

#### 1. Motion-Activated Light (v1.0.0)
**Accende luci al rilevamento di movimento**
- Rileva movimento con sensore binario
- Spegne automaticamente dopo timeout configurabile
- Regola la luminosità a piacere
- Perfetto per: bagni, corridoi, scale

#### 2. Door Sensor Alert (v1.1.0)
**Ricevi notifiche all'apertura porte**
- Monitora sensori di contatto
- Notifiche su smartphone o altre piattaforme
- Filtro opzionale basato sulla presenza (avvisa solo quando sei fuori)
- Perfetto per: sicurezza, monitoraggio porte

#### 3. Temperature Threshold Alert (v1.0.0)
**Azioni al raggiungimento di temperature limite**
- Trigger su temperature massime e minime
- Azioni separate per ogni soglia
- Perfetto per: protezione dal gelo, controllo HVAC, monitoraggio

### Script

#### Gentle Wake-Up (v1.0.0)
**Sveglia dolce con illuminazione graduale**
- Accrescenza graduale di luminosità su 30 minuti (configurabile)
- Simula l'alba naturale
- Perfetto per: sveglia mattutina, routine del sonno

---

## ⚙️ Requisiti

### Home Assistant
- Versione **2023.6.0** o successiva (consigliato: ultima disponibile)
- Accesso amministratore per importare blueprint

### Integrazioni necessarie
Dipendono dai blueprint che usi:
- **Sensori di movimento**: Qualsiasi integrazione con sensori binari (Philips Hue, Aqara, Zigbee, Z-Wave, etc.)
- **Luci**: Qualsiasi integrazione con luci (Philips Hue, IKEA Tradfri, Tasmota, etc.)
- **Sensori di temperatura**: Qualsiasi integrazione con sensori di temperatura
- **Notifiche**: Servizio notify integrato (mobile_app, webhook, email, etc.)

---

## 🔧 Come Usare un Blueprint

### Metodo 1: Import Badge (Consigliato)
1. Nel file [README.md](./README.md), accanto a ogni blueprint c'è un badge "Import"
2. Clicca il badge
3. Home Assistant si aprirà automaticamente con l'importazione guidata
4. Configura i parametri secondo le tue necessità
5. Salva e abilita l'automazione

### Metodo 2: Importazione Manuale
1. Copia l'URL del blueprint (vedi tabella in README.md)
2. Vai a **Impostazioni → Automazioni e Scene → Blueprint**
3. Clicca **Importa Blueprint**
4. Incolla l'URL
5. Completa la procedura

### Metodo 3: Clone Repository (Per Sviluppatori)
```bash
git clone https://github.com/yourname/ha-blueprints.git
cd ha-blueprints
# Copia i file .yaml nella cartella blueprints di Home Assistant
```

---

## 📝 Esempio: Accendere la Luce al Movimento

1. Apri **Impostazioni → Automazioni e Scene → Blueprint**
2. Clicca su **Crea automazione** → seleziona "Motion-Activated Light"
3. Configura:
   - **Sensore movimento**: `binary_sensor.bagno_movimento` (o il tuo sensore)
   - **Luce**: `light.bagno_principale` (o la tua luce)
   - **Timeout**: `5` minuti
   - **Luminosità**: `80`%
4. Clicca **Salva** e abilita l'automazione

Fatto! La luce del bagno si accenderà quando rileva movimento e si spegnerà dopo 5 minuti di inattività.

---

## ❓ Domande Frequenti

### Come faccio a sapere se un blueprint è stato importato correttamente?
Vai a **Impostazioni → Automazioni e Scene → Blueprint** - dovrebbe essere visibile nell'elenco.

### Cosa succede se la mia versione di Home Assistant è vecchia?
Alcuni blueprint potrebbero non funzionare. Controlla la versione minima richiesta nel README e aggiorna Home Assistant se necessario.

### Posso modificare un blueprint dopo averlo importato?
Sì! Puoi modificare l'automazione creata dal blueprint in qualsiasi momento. Se vuoi modificare il template stesso, vedi [CONTRIBUTING.md](./CONTRIBUTING.md).

### Come creo il mio blueprint?
Leggi [BLUEPRINT_GUIDE.md](./docs/BLUEPRINT_GUIDE.md) per una guida completa. È più facile di quanto pensi!

### Posso condividere i miei blueprint?
Assolutamente! Leggi [CONTRIBUTING.md](./CONTRIBUTING.md) per sapere come contribuire.

---

## 🐛 Problemi?

### L'automazione non si attiva
1. Verifica che l'automazione sia **abilitata** (interruttore blu)
2. Controlla che l'entità selezionata esista (Impostazioni → Strumenti per sviluppatori → Stati)
3. Leggi il file di log: **Impostazioni → Sistema → Log**

Consulta [TROUBLESHOOTING.md](./docs/TROUBLESHOOTING.md) per soluzioni dettagliate.

### Non riesco a trovare un'entità
L'entità non esiste ancora nel tuo sistema.

Soluzione:
1. Installa l'integrazione richiesta
2. Aggiungi il dispositivo tramite l'integrazione
3. Attendi il rilevamento
4. Riprova

Esempio: Nessun sensore di movimento disponibile?
→ Installa un'integrazione con sensori di movimento (Philips Hue, Aqara, Zigbee, etc.) e aggiungi il dispositivo.

---

## 📖 Ulteriore Documentazione

- **[SETUP.md](./docs/SETUP.md)** - Guida di configurazione dettagliata
- **[BLUEPRINT_GUIDE.md](./docs/BLUEPRINT_GUIDE.md)** - Come funzionano i blueprint
- **[FAQ.md](./docs/FAQ.md)** - Risposte a domande comuni
- **[TROUBLESHOOTING.md](./docs/TROUBLESHOOTING.md)** - Risolvere problemi

---

## 🤝 Contribuire

Hai un'idea per un nuovo blueprint? Perfetto! Leggi [CONTRIBUTING.md](./CONTRIBUTING.md) per sapere come:
- Crearne uno proprio
- Sottometterlo a questo repository
- Seguire le linee guida di qualità

---

## 📄 Licenza

Questo progetto è rilasciato sotto licenza **MIT** - vedi [LICENSE](./LICENSE) per i dettagli.

Tutti i blueprint sono **gratuiti** e puoi usarli, modificarli e ridistribuirli liberamente con attribuzione.

---

## 🔗 Link Utili

- [Documentazione ufficiale Home Assistant](https://www.home-assistant.io/docs/blueprint/)
- [Schema Blueprint ufficiale](https://www.home-assistant.io/docs/blueprint/schema/)
- [Forum Community Home Assistant](https://community.home-assistant.io/)
- [Blueprint Hub](https://hablueprints.directory/)

---

## 💡 Pro Tips

1. **Leggi le descrizioni**: Ogni blueprint ha una descrizione dettagliata di cosa fa
2. **Sfrutta i valori di default**: Vengono scelti per essere ragionevoli nella maggior parte dei casi
3. **Crea più automazioni**: Puoi usare lo stesso blueprint multiple volte con configurazioni diverse
4. **Controlla i log**: Se qualcosa non funziona, il log è il tuo miglior amico
5. **Partecipa alla community**: Il Forum di Home Assistant è pieno di persone pronte ad aiutare

---

**Domande?** Apri una [GitHub Issue](https://github.com/Odyno/ha-blueprints/issues) o scrivi nel [Forum Community](https://community.home-assistant.io/c/blueprints-exchange/53)!

**Ultimo aggiornamento**: 2026-03-29
