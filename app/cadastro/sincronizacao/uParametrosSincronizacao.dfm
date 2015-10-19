object ParametrosSincronizacao: TParametrosSincronizacao
  Left = 0
  Top = 0
  Width = 305
  Height = 161
  TabOrder = 0
  object Label1: TLabel
    Left = 13
    Top = 10
    Width = 138
    Height = 13
    Caption = 'Endere'#231'o para sincroniza'#231#227'o'
  end
  object lblNomeFrame: TLabel
    Left = 188
    Top = 6
    Width = 67
    Height = 13
    Caption = 'Sincroniza'#231#227'o'
    Visible = False
  end
  object btnConfirmar: TcxButton
    Left = 133
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Cofirmar'
    TabOrder = 0
    OnClick = btnConfirmarClick
  end
  object btnCancelar: TcxButton
    Left = 210
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Restaurar'
    TabOrder = 1
    OnClick = btnCancelarClick
  end
  object edtIp: TEdit
    Left = 14
    Top = 26
    Width = 268
    Height = 21
    TabOrder = 2
  end
  object gpbTempoSinc: TGroupBox
    Left = 16
    Top = 56
    Width = 269
    Height = 63
    Caption = 'Intervalo para sincroniza'#231#227'o'
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 17
      Width = 28
      Height = 13
      Caption = 'Horas'
    end
    object Minutos: TLabel
      Left = 128
      Top = 17
      Width = 37
      Height = 13
      Caption = 'Minutos'
    end
    object edtHoras: TEdit
      Left = 8
      Top = 31
      Width = 118
      Height = 21
      TabOrder = 0
    end
    object edtMinutos: TEdit
      Left = 128
      Top = 31
      Width = 121
      Height = 21
      TabOrder = 1
    end
  end
  object btnSincronizar: TcxButton
    Left = 5
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Sincronizar'
    TabOrder = 4
    OnClick = btnSincronizarClick
  end
end
