### ざっくりやりたいこと
・無料枠の範囲で各AZのパブリックサブネットに1台のEC2を配置
・ALBで各AZのEC2に分散
・プライベートサブネットにRDSを置き、Active-Standby
・ネットワーク構成をTerraformでコード化
・terraform planを実行しながらTDD的に作る


### 構築の順番
#### VPCの作成 ※各手順間にterraform planを実行
1. とりあえずCIDRと名前だけ指定して作ってみる
2. variableにservice_name、env、vpc_cidr_blockを指定し、vpcの定義も書き換える。命名規則を決定。

#### サブネットの作成
1. cidr_blockをハードコードしてパブリック、プライベートサブネットを作ってみる
2. variableにsubnet_cidrsを指定し、main.tfにもCIDRを書いておく。cidr_blockをfor_eachでぶん回す
3. dataでazを定義する。サブネットにaz定義を追加し、まずは.name[0]で一つ目のazで立ててみる(サブネットが重複しても構わない)
4. var.subnet_cidrs.privateというリスト内のeach.valueを検索し、AZの数で割った余り番目のAZを割り当てる

#### IGWの作成
1. IGWはVPCに紐づくため、VPCのIDにaws_vpc.vpc.idを設定。名前と環境変数はいつも通りに

#### Elastic IPの作成
1. domain="vpc"が最小構成要件
2. aws_subnet.public_subnetsをfor_eachでぶん回す


#### NATゲートウェイの作成
1. allocation_idにeipのidを、subnet_idにはパブリックサブネットのidを紐づけ
2. すでにリストで複数サブネットを作っている場合はfor_eachでぶん回す