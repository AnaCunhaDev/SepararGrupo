class Person {
  String id;
  String nome;
  int classificacao;
  int idade;
  bool isActive;

  Person({
    this.id,
    this.nome,
    this.classificacao = 1,
    this.idade,
    this.isActive = false,
  });
}
