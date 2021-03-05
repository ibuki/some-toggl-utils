# Some Toggl Utils

This script gets the last month summary pdf for each client.

Because of Togglv8 reports function doesn't work, Faraday is also required.

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
thor status:dump_settings >> config/settings.yml
```

5. Run the script and get your report

```bash
thor export:summaries
```

6. Enjoy the results

```bash
open results
```

7. You can also see your worked durations in cli

```bash
thor status:durations_in_last_month
thor status:durations_in_this_month
```

results:
```
2021-02-01〜2021-02-28の活動時間
companya       : 6時間23分 (6.38h)
companyb       : 28時間36分 (28.60h)
total          : 34時間59分 (34.98h)
```
