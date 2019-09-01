# Toggl summary downloader

This script gets the last month summary pdf for each client.

Because of Togglv8 reports don't work, Faraday is also required.

# Usage

1. Get your api token from Toggl.
https://toggl.com/app/profile

2. Set your api token at the file `config/settings.yml`

```bash
cp config/settings.sample.yml config/settings.yml
vi config/settings.yml
```

3. Install dependancies

```bash
bundle install
```

4. Get your client_ids and update your settings.yml

```bash
thor init:fetch_client_ids >> config/settings.yml
```

5. Run the script and get your report

```bash
thor expot:summaries
```

6. Enjoy the results

```bash
open results
```
