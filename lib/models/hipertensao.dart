class Hipertensao {
  String? unidadeSaude;
  String? dsCBO;
  String? nomeProfissional;
  String? dtUltAtendimento;
  double? pressao;
  String? medicacao;

  Hipertensao({
    this.unidadeSaude,
    this.dsCBO,
    this.nomeProfissional,
    this.dtUltAtendimento,
    this.pressao,
    this.medicacao,
  });
}

class UserData {
  String? cpf;
  String? dtNasc;
  String? nome;
  String? nomeMae;
  String? endereco;
  double? imc;
  String? classImc;
  String? token;

  UserData({
    this.cpf,
    this.dtNasc,
    this.nome,
    this.nomeMae,
    this.endereco,
    this.imc,
    this.classImc,
    this.token,
  });
}
