# rstudio_scrnaseq

## scRNA-seq 解析 Rstudio server Docker の簡単な使い方

### [1] `docker run` によるコンテナの起動
以下のコマンドを好きな場所で実行するだけでコンテナを起動することができる。  
docker image がダウンロードされていない場合は、ダウンロードから実行される。  
ダウンロードが正常に終了すると、コンテナが起動する。  

#### Linux、WSL2、Intel Mac上でコンテナを起動して使用する場合

```bash
docker run --rm --name acctest -dit \
--mount type=bind,src=$PWD,dst=/home/rstudio \
-e USERID=$(id -u) \
-e GROUPID=$(id -g) \
-e PASSWORD="testpass" \
-p 8787:8787 \
hway/rstudio_scrnaseq
```

#### M1/M2 Mac上でコンテナを起動して使用する場合

```bash
docker run --rm --name acctest -dit \
--mount type=bind,src=$PWD,dst=/home/rstudio \
-e USERID=$(id -u) \
-e GROUPID=$(id -g) \
-e PASSWORD="testpass" \
-p 8787:8787 \
hway/rstudio_scrnaseq_arm64
```

#### `docker run` のオプションの説明とカスタマイズのヒント

- `--name acctest`: acctestはコンテナの名前なので自分で名前を付ける
- `--mount type=bind,src=$PWD,dst=/home/rstudio`: ホストとコンテナのどの部分を共有するかの設定 このコマンドを実行したディレクトリ(`$PWD`)以下がコンテナの`/home/rstudio`以下と同一視される
- `-e USERID=$(id -u)`: ホストとコンテナでのユーザを同一にする設定
- `-e GROUPID=$(id -g)`: ホストとコンテナでのユーザを同一にする設定
- `-e PASSWORD="testpass"`: "testpass" は任意なので自分でパスワードを設定する
- `-p 8787:8787`: ポートの設定は自由に変更可能 (-p ホストのポート:コンテナのポート)
- `hway/rstudio_scrnaseq`: 使用したい docker image を記載する (M1/M2 Mac上でコンテナを起動して使用する場合は、 `hway/rstudio_scrnaseq_arm64` を指定する)


### [2] scRNA-seq 解析 Rstudio server へのアクセス
エラーなくコンテナが起動したらウェブブラウザで以下にアクセスする。

#### ローカルPCでコンテナを起動した場合  

```http://localhost:8787/```  

- `docker run` の際の `-p` オプションで、ホストのポートを8787以外に変えた場合は、上記URLの `:` 以降のポート番号を書き換えてください。

#### リモートサーバ等でコンテナを起動した場合  

```http://138.22.8.8:8787/```  

- `//` と `:` の間の部分（上記の例だと`138.22.8.8`）は使用するサーバーのIPアドレスで置き換えてください。  
- `docker run` の際の `-p` オプションで、ホストのポートを8787以外に変えた場合は、上記URLの `:` 以降のポート番号を書き換えてください。

### [3] scRNA-seq 解析 Rstudio server へのログイン

1. Rstudio server のログイン画面が表示される。

2. 以下を入力しRstudio server にログインする。

```
username: rstudio
password: testpass # 上記の docker run コマンドを実行した場合
```

3. R studio が使える状態になりました。  

### その他の docker 操作

* コンテナが起動状況を確認したい場合

```bash
docker ps -a
```
起動していれば、acctest UP と表示されるはず。


* 起動しているコンテナを削除したい場合

```bash
docker stop acctest      # 起動中のコンテナの停止
```


### RStudio Server マルチユーザー設定

このドキュメントでは、Docker コンテナ内で RStudio Server をマルチユーザー環境で利用するための設定手順を説明します。

#### 前提条件
- ホストマシンに Docker がインストールされていること
- RStudio Server のコンテナが稼働していること
- ユーザー情報がリスト化されていること

#### マルチユーザーの追加手順

##### 1. 実行中のコンテナにアクセス
まず、以下のコマンドを使用して RStudio Server コンテナに入ります。

```sh
docker exec -it scrnaseq_handson /bin/bash
```

##### 2. コンテナ内でユーザーを追加
コンテナ内で、以下のコマンドを実行して、事前に用意したユーザーリストからユーザーを作成します。

```sh
newusers /home/rstudio/env/user_list.txt
```

**注意:** `user_list.txt` の保存場所は、コンテナ内の任意のディレクトリで問題ありません。

##### 3. コンテナから退出
ユーザー作成コマンドの実行後、コンテナからホストへ戻ります。

```sh
exit
```

#### ユーザーリストのフォーマット
`user_list.txt` ファイルには、以下のフォーマットでユーザー情報を記載します。

```plaintext
<ユーザー名>:<パスワード>::::<ホームディレクトリ>:/bin/bash
```

##### ユーザーリストの例
```plaintext
user1:c5VGXTrh::::/home/rstudio/users/user1:/bin/bash
user2:Hg8P5FsL::::/home/rstudio/users/user2:/bin/bash
user3:n5WeQpf6::::/home/rstudio/users/user3:/bin/bash
user4:x2E5TSXP::::/home/rstudio/users/user4:/bin/bash
user5:wE7jNKfp::::/home/rstudio/users/user5:/bin/bash
```

各ユーザーのユーザー名とパスワードは一意である必要があり、適切なホームディレクトリを指定してください。

#### 注意事項
- `newusers` コマンドは `user_list.txt` から一括でユーザーを作成します。
- 各ユーザーのホームディレクトリを明示的に指定し、重複を避けてください。
- パスワードの管理には注意し、公開リポジトリに直接記載しないようにしてください。

この設定を行うことで、複数のユーザーがそれぞれのアカウントを使用して RStudio Server を利用できるようになります。

