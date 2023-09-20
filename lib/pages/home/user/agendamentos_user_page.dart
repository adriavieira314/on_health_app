import 'package:flutter/material.dart';
import 'package:on_health_app/exceptions/http_exception.dart';
import 'package:on_health_app/models/agendamentos.dart';
import 'package:on_health_app/providers/agendamentos_provider.dart';
import 'package:provider/provider.dart';
import 'package:on_health_app/utils/capitalize.dart';

class AgendamentosUserPage extends StatefulWidget {
  const AgendamentosUserPage({super.key});

  @override
  State<AgendamentosUserPage> createState() => _AgendamentosUserPageState();
}

class _AgendamentosUserPageState extends State<AgendamentosUserPage> {
  bool loading = true;
  bool _isButtonConfirma = false;
  bool _isButtonCancela = false;

  @override
  void initState() {
    super.initState();
    Provider.of<AgendamentosProvider>(
      context,
      listen: false,
    ).loadAgendamentosUsuario().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _changeStatus(stts, id, cpf, agendamento) async {
    setState(
      () => stts == 1 ? _isButtonConfirma = true : _isButtonCancela = true,
    );

    AgendamentosProvider agendamentos = Provider.of(context, listen: false);

    try {
      await agendamentos.changeAgendamentoStatus(stts, id, cpf);
      setState(() {
        agendamento.stAgendamento = stts;
      });
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog(
          'Ocorreu um erro no processo. $error Entre em contato com suporte técnico.');
    }

    setState(
      () => stts == 1 ? _isButtonConfirma = false : _isButtonCancela = false,
    );
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final listaAgendamentos = Provider.of<AgendamentosProvider>(
      context,
      listen: true,
    ).listaAgendamentosUsuario;

    return loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : listaAgendamentos == null
            ? Center(
                child: Text(
                  'Sem agendamentos',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: listaAgendamentos.agendamentos!.length,
                itemBuilder: (BuildContext context, int index) {
                  Lista lista = listaAgendamentos.agendamentos![index];

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: lista.agendamentos!.length,
                    itemBuilder: (BuildContext context, int index) {
                      Agendamentos agendamento = lista.agendamentos![index];

                      return Card(
                        elevation: 3,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.date_range),
                                  ],
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Especialidade: ${agendamento.dsCBO!.capitalizeByWord()}',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Profissional: ${agendamento.nmProfSaude!.capitalizeByWord()}',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                  ],
                                ),
                                subtitle: Text(
                                  'Data: ${agendamento.dtAgenda}',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: agendamento.stAgendamento == 0
                                          ? () => {
                                                _changeStatus(
                                                  1,
                                                  agendamento.id,
                                                  agendamento.cpf,
                                                  agendamento,
                                                ),
                                              }
                                          : agendamento.stAgendamento == 1
                                              ? null
                                              : () => {
                                                    _changeStatus(
                                                      1,
                                                      agendamento.id,
                                                      agendamento.cpf,
                                                      agendamento,
                                                    ),
                                                  },
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        minimumSize: const Size(100, 40),
                                      ),
                                      child: !_isButtonConfirma
                                          ? Text('Confirmar')
                                          : CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                    ),
                                    const SizedBox(width: 8),
                                    ElevatedButton(
                                      onPressed: agendamento.stAgendamento == 0
                                          ? () => {
                                                _changeStatus(
                                                  2,
                                                  agendamento.id,
                                                  agendamento.cpf,
                                                  agendamento,
                                                ),
                                              }
                                          : agendamento.stAgendamento == 2
                                              ? null
                                              : () => {
                                                    _changeStatus(
                                                      2,
                                                      agendamento.id,
                                                      agendamento.cpf,
                                                      agendamento,
                                                    ),
                                                  },
                                      style: ElevatedButton.styleFrom(
                                        shape: const StadiumBorder(),
                                        minimumSize: const Size(100, 40),
                                        backgroundColor:
                                            Theme.of(context).colorScheme.error,
                                      ),
                                      child: !_isButtonCancela
                                          ? Text('Cancelar')
                                          : CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
  }
}
