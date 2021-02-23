enum Tipos {
  Misto,
  Aleatorio,
  Idade,
}

class FilterModel {
  bool isCheckedPorIdade;
  bool isCheckedPorIdadadeEquilibrada;
  bool isCheckedBemAleatorio;
  int qtd;
  int tam;
  int sobra;

  FilterModel({
    this.tam,
    this.qtd,
    this.isCheckedBemAleatorio,
    this.isCheckedPorIdade,
    this.isCheckedPorIdadadeEquilibrada,
    this.sobra,
  }) {
    this.tam = 1;
    this.qtd = 1;
    this.sobra = 0;
    this.isCheckedBemAleatorio = false;
    this.isCheckedPorIdadadeEquilibrada = false;
    this.isCheckedPorIdade = false;
  }

  static Tipos verify(FilterModel filter) {
    if (!filter.isCheckedBemAleatorio &&
        !filter.isCheckedPorIdade &&
        filter.isCheckedPorIdadadeEquilibrada) {
      return Tipos.Misto;
    } else if (!filter.isCheckedBemAleatorio &&
        filter.isCheckedPorIdade &&
        !filter.isCheckedPorIdadadeEquilibrada) {
      return Tipos.Idade;
    }
    return Tipos.Aleatorio;
  }
}
