# gcp_scheduler

gcp_schedulerは、Google Cloud Schedulerを簡単に操作できるコマンドラインツールです。
create、list、deleteのコマンドでCloud Schedulerのジョブを追加、表示、削除できます。

## インストール

```
gem install gcp_scheduler
```

## 使い方

以下のコマンド例を参考にして、CLIを使用してください。

各コマンドは認証情報を下記のように環境変数で設定してある状態で実行する必要があります。

```
export GOOGLE_APPLICATION_CREDENTIALS=your_credential.json
```

### ジョブの作成

```
gcp_scheduler create --gcp_project your_project_name --scheduler_file path/to/scheduler.yml --prefix development- --region asia-northeast1
```

- scheduler_fileを元にジョブを作成します。
- prefixは、ジョブ名に付与されるプレフィックスです。
- regionは、Cloud Schedulerのリージョンです。

### ジョブの一覧表示

```
gcp_scheduler list --gcp_project your_project_name --prefix development- --region asia-northeast1
```

### ジョブの削除

```
gcp_scheduler delete --gcp_project your_project_name --prefix development- --region asia-northeast1
```

- prefixで指定した文字列から始まるジョブ名のジョブをすべて削除します。

## コマンドオプション

| Option | Description                                                                               |
|---|-------------------------------------------------------------------------------------------|
| `--gcp_project` | Google Cloud project name                                                                 |
| `--scheduler_file` | Path to the scheduler configuration file (used with `create` command)                     |
| `--prefix` | Prefix for the job name (used with `create`, `list`, and `delete` commands)               |
| `--region` | Cloud Scheduler region                                                                    |

## scheduler.yml file

`--scheduler_file`オプションでyamlファイルを指定してください。スケジュールを定義するために使用されます。以下は、scheduler.ymlファイルのサンプルです。

```yaml
jobs:
  - name: WeeklyJob
    description: 'Runs every week at 9:00 a.m. Created:<%= Time.now.strftime("%Y/%m/%d %-H:%M") %>'
    schedule: '0 9 * * *'
    time_zone: Asia/Tokyo
    uri: https://yourdomain.example.com/api/v1/jobs
    http_method: POST
    params:
      job_name: weekly_job
    http_headers:
      Content-Type: application/json
      Authorization: 'Bearer <%= ENV["SECRET"] %>'
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bluerabbit/gcp_scheduler.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
