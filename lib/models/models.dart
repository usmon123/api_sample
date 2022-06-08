class CurrencyRate{
  String? title;
  String? code;
  String? cb_price;
  String? nbu_buy_price;
  String? nbu_sell_price;
  String? date;

  CurrencyRate({this.title,this.code,this.date,this.cb_price,this.nbu_buy_price,this.nbu_sell_price});

  CurrencyRate.fromJson(Map<String, dynamic> json){
    title=json['title'];
    code=json['code'];
    cb_price=json['cb_price'];
    nbu_sell_price=json['nbu_sell_price'];
    nbu_buy_price=json['nbu_buy_price'];
    date=json['date'];
  }
}