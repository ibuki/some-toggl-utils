# Toggl summary downloader

This script gets the last month summary pdf for each client.

Because of Togglv8 reports don't work, Faraday is also required.

# Usage

1. Get your api token from Toggl.
https://toggl.com/app/profile

2. Set your api token at the file `settings.yml`

```bash
vi settings.yml
```

3. Install dependancies

```bash
bundle install
```

4. Get your client_ids

```bash
bundle exec ruby get_client_ids.rb
```

5. Update your settings using results of above script

```bash
vi settings.yml
```

6. Run the script and get your report

```bash
bundle exec ruby get_last_month_summaries.rb
```

7. Enjoy the results

```bash
open results
```
