# rstudio_scrnaseq

## scRNA-seq 解析 Rstudio server Docker の簡単な使い方

### コンテナの起動
以下のコマンドを好きな場所で実行するだけでコンテナを起動することができる。  
docker image がダウンロードされていない場合は、ダウンロードから実行される。  
ダウンロードが正常に終了すると、コンテナが起動する。  

```bash
docker run --name acctest -dit \                  # acctestはコンテナの名前なので自分で名前を付ける
--mount type=bind,src=$PWD,dst=/home/rstudio \    # ホストとコンテナのどの部分を共有するかの設定 このコマンドを実行したディレクトリ($PWD)以下がコンテナの/home/rstudio以下と同一視される
-e USERID=$(id -u) \                              # ホストとコンテナでのユーザを同一にする設定
-e GROUPID=$(id -g) \                             # ホストとコンテナでのユーザを同一にする設定
-e PASSWORD="testpass" \                          # "testpass"は任意なので自分でパスワードを設定する
-p 8787:8787 \                                    # ポートの設定は自由に変更可能 (-p ホストのポート:コンテナポート)
hway/rstudio_scrnaseq                             # 使用したいdocker image を記載する (M1/M2 Mac上でコンテナを起動して使用する場合は、hway/rstudio_scrnaseq_arm64を指定する)
```

### scRNA-seq 解析 Rstudio server へのアクセス
エラーなくコンテナが起動したらブラウザで以下にアクセスする。

* ローカルPCでコンテナを起動した場合  

```http://localhost:8787/```  

* リモートサーバ等でコンテナを起動した場合  

```http://138.22.8.8:8787/ #  (138.22.8.8の部分は使用するサーバーのIPアドレスで置き換えてください)```  

Rstudio server のログイン画面が表示される。

以下を入力しRstudio server にログインする。

```
username: rstudio
password: testpass # 上記の docker run コマンドを実行した場合
```

R studio が使える状態になりました。

### その他の docker 操作

* コンテナが起動状況を確認したい場合

```bash
docker ps -a
```
acctest UP と表示されるはず。


* 起動しているコンテナを削除したい場合

```bash
docker stop acctest      # 起動中のコンテナの停止
docker rm acctest        # コンテナの削除
```


