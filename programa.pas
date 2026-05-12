unit programa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, TeeProcs, TeEngine, Chart, Series;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label222: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edhidrogenio: TEdit;
    Label8: TLabel;
    Label9: TLabel;
    ednitrogenio: TEdit;
    edenxofre: TEdit;
    educomb: TEdit;
    edcinza: TEdit;
    eduar: TEdit;
    edcnq: TEdit;
    edfi: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label12: TLabel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Bevel3: TBevel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Bevel8: TBevel;
    radiotipo: TRadioGroup;
    btbalancear: TButton;
    btlimpar: TButton;
    btfechar: TButton;
    radiocnq: TRadioGroup;
    radioac: TRadioGroup;
    radiogas: TRadioGroup;
    Bevel7: TBevel;
    resultado: TLabel;
    edcarb: TEdit;
    Label5: TLabel;
    edoxigenio: TEdit;
    Label16: TLabel;
    Label17: TLabel;
    resultado2: TLabel;
    resultado3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    radiodoscombustivel: TRadioGroup;
    Label18: TLabel;
    Bevel9: TBevel;
    resultado4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Bevel10: TBevel;
    Label19: TLabel;
    Label20: TLabel;
    procedure btlimparClick(Sender: TObject);
    procedure btfecharClick(Sender: TObject);
    procedure btbalancearClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure radiotipoClick(Sender: TObject);
    procedure radiodoscombustivelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

private
    { Private declarations }
  public
    { Public declarations }
  end;

var             //q = quantidade (mol ou kilo)
                //coef = coeficiente
                //aux = auxiliares para alguns calculo e evitar ''X/0''
                //p = porcetagem (%)
                //sp = string da porcentagem
                //str = string

  Form1: TForm1;

  // variaveis reais (floating point operations)
  qcarbono, qhidrogenio, qnitrogenio, qenxofre, qcinza, quar,
  qcnq, qucomb, qfi, qoxigenio, qar, qco2, qso2, qn2, qh2o, qco, qo2,
  ac, aux, aux1, aux2, aux3, pco2, po2, pco, pn2, pso2, ph2o, qo : Real;

  // strings (exibiçao)
  coefcarbono, coefhidrogenio, coefenxofre, coefnitrogenio,
  coefoxigenio, coefucomb, coefcinzas, coefar, coefco2,
  coefh2o, coefco, coefn2, coefo2, coefso2, coefcnq, strac,
  spco2, spo2, spco, spn2, sph2o, spso2  : string;

  //strings novas

 stringtemp: string;
 clinha: integer      ;

 //novas vars para loopings //balanço energetico

 hf, x, y, z, f, S, T: real;
  hf1, hf2, hf3, hf4, hf5: real;
  b11, b21, b31, b41, b51: real;
  b12, b22, b32, b42, b52: real;
  c11, c21, c31, c41, c51: real;
  c12, c22, c32, c42, c52: real;
  K, L, M, N, O, P, fi, Ta: array[1..13] of real;
  i,j,d: integer;


implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form2.show
end;


procedure TForm1.btlimparClick(Sender: TObject);
begin
  radiodoscombustivel.itemindex := -1 ;
  button2.enabled:=false;
  edcarb.text:= '';
  edhidrogenio.Text := '';
  edenxofre.Text := '';
  edcinza.Text := '';
  ednitrogenio.Text := '';
  eduar.Text := '';
  edfi.Text := '1,00';
  edcnq.Text := '';
  educomb.Text := '';
  radiotipo.ItemIndex := 0;
  radiocnq.ItemIndex := 0;
  radiogas.ItemIndex := 0;
  radioac.ItemIndex := 0;
  resultado.Caption := '';
  resultado2.Caption := '';
  edoxigenio.text := '';
  resultado3.Caption := '';
  //t0 := 1500;
 d:=1;

While d<14 do
 begin
  ListBox1.ItemIndex:=0;
  ListBox2.ItemIndex:=0;
  ListBox1.Items.Delete(ListBox1.ItemIndex);
  ListBox2.Items.Delete(ListBox2.ItemIndex);
  d:=d+1;
 end


end;

procedure TForm1.btfecharClick(Sender: TObject);
begin
close;
end;

procedure TForm1.btbalancearClick(Sender: TObject);
begin

  if (edoxigenio.text='') then
  qoxigenio:=0
  else
  qoxigenio:= strtofloat (edoxigenio.text);
  if (edcarb.Text='')then
  qcarbono :=0
  else
  qcarbono:= strtofloat (edcarb.text);
  if (edhidrogenio.Text='') then
  qhidrogenio := 0
  else
  qhidrogenio :=  strtofloat(edhidrogenio.Text);
  if (ednitrogenio.Text='') then
  qnitrogenio := 0
  else
  qnitrogenio  :=  strtofloat(ednitrogenio.Text) ;
  if (edenxofre.text='') then
  qenxofre :=0
  else
  qenxofre :=  strtofloat(edenxofre.Text);
  if (educomb.text='') then
  qucomb := 0
  else
  qucomb :=  strtofloat(educomb.Text)  ;
  if (edcnq.text ='') then
  qcnq := 0
  else
  qcnq := strtofloat(edcnq.Text)  ;
  if (edfi.text ='') then
  qfi := 1
  else
  qfi :=  strtofloat(edfi.Text) ;
  if (eduar.Text ='')then
  quar := 0
  else
  quar := strtofloat (eduar.text);
  if (edcinza.text='') Then
  qcinza:= 0
  else
  qcinza:=strtofloat(edcinza.text);




if (radiotipo.ItemIndex = 0) then //inicio do calculo base massica

    begin

    if (qfi = 1) then
        begin

    aux := qcnq/12;
    if (radiocnq.Itemindex = 0) then
    qcnq := ((aux/100)*qcinza)/(1-(aux/100))
    else if (radiocnq.ItemIndex = 1) then
    qcnq := qcnq*(qcarbono + qnitrogenio + qenxofre + qucomb + qoxigenio +
    qhidrogenio + qcinza);

    qcarbono := qcarbono/12 ;
    qnitrogenio := qnitrogenio/14  ;
    qenxofre:= qenxofre/32;
    qucomb := qucomb/18;
    qoxigenio := qoxigenio/16;
    //ninjice de joao (joaozice)
    qar :=  (qenxofre)+(qhidrogenio/4)+(qcarbono)-(qoxigenio/2);
    qco2 := qcarbono - qcnq;
    qso2:= qenxofre;
    qh2o := (qhidrogenio/2+ qucomb + qar*(quar*137.28/18)) ;  //otra ninjice
    qn2 :=  (qnitrogenio/2 + qar*3.76) ;
    qo2 := qcnq ;
    qco := 0;


      if (radioac.itemindex = 0 ) then
        begin
           aux1 := (qcarbono*12 + qhidrogenio + qnitrogenio*14 + qenxofre*32 +
           qoxigenio*16 + qcinza + qucomb*18);
         if (aux1 = 0) then
          resultado2.Caption:= 'Não há combustivel ou ar'
         else
            ac := qar*(137.28 + quar*137.28)/(qcarbono*12 + qhidrogenio +
            qnitrogenio*14 + qenxofre*32 + qoxigenio*16 + qcinza + qucomb*18);
         end

      else if (radioac.ItemIndex = 1) then
        begin
          aux1:= (qcarbono + qhidrogenio + qnitrogenio + qenxofre +
          qoxigenio + qucomb);
          if (aux1 = 0) then
           resultado2.caption:= 'Não há combustivel ou ar'
          else
            ac := qar*(4.76 + quar );
             ///qcarbono + qhidrogenio + qnitrogenio + qenxofre +
            // qoxigenio + qucomb);
          end;


 /////inicio da pog do resultado 3 /////

        if (radiogas.ItemIndex = 0) then
          begin
           aux3 := (qco2 + qco + qso2 + qo2 + qn2);
            if (aux3 <> 0) then
              begin
               pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2));
               pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2));
               pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2));
               po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2));
               pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2));
               sph2o := '';
              if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
            end;
          end

        else if (radiogas.itemindex = 1) then
          begin
          aux3 := (qco2 + qco + qso2 + qo2 + qn2 + qh2o);
           if (aux3 <> 0) then
            begin
            pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            ph2o := 100*(qh2o/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
               if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
               if (ph2o = 0) then
                  sph2o := ''
               else
                  sph2o := formatfloat ('0.00', ph2o)+'%H2O ';
            end;
          end;


   if (aux3 <> 0 ) then
   resultado3.Caption := 'Analise dos gases: '+spco2+spco+spo2+sph2o+spso2+spn2
   else if (aux3 = 0) then
    resultado3.Caption:= 'Não há produtos de combustão';

        //// fim da pog dos gas


    if (qcarbono = 0) then
    coefcarbono := ''
    else
    coefcarbono := formatfloat ('0.00', qcarbono)+'C + ';
    if  (qhidrogenio = 0) then
    coefhidrogenio := ''
    else
    coefhidrogenio := formatfloat ('0.00', qhidrogenio)+'H + ';
    if (qnitrogenio = 0) then
    coefnitrogenio := ''
    else
    coefnitrogenio := formatfloat ('0.00', qnitrogenio)+'N + ';
    if (qoxigenio = 0) then
    coefoxigenio := ''
    else
    coefoxigenio := formatfloat ('0.00', qoxigenio)+'O + ';
    if (qenxofre = 0) then
    coefenxofre := ''
    else
    coefenxofre := formatfloat ('0.00', qenxofre)+'S + ';
    if (qucomb = 0) then
    coefucomb := ''
    else
    coefucomb := formatfloat ('0.00', qucomb)+'H2O + ';
    if (qar = 0) then
    coefar := ''
    else
    if (quar = 0) then
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2)'
    else
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2 + '+
    formatfloat ('0.00',(quar*137.28/18))+'H2O)';
    if (qco2 = 0) then
    coefco2 := ''
    else
    coefco2 := formatfloat ('0.00', qco2)+'CO2 + ';
    if (qh2o = 0) then
    coefh2o := ''
    else
    coefh2o := formatfloat ('0.00', qh2o)+'H2O + ';
    if (qso2 = 0) then
    coefso2 := ''
    else
    coefso2 := formatfloat ('0.00', qso2)+'SO2 + ';
    if (qn2 = 0) then
    coefn2 := ''
    else
    coefn2 := formatfloat ('0.00', qn2)+'N2';
    if (qco = 0) then
    coefco := ''
    else
    coefco := formatfloat ('0.00', qco)+'CO + ';
    if (qo2 = 0) then
    coefo2 :=''
    else
    coefo2 := formatfloat ('0.00', qo2)+'O2 + ';
    if (qcnq = 0) then
    coefcnq := ''
    else
    coefcnq := formatfloat ('0.00', qcnq)+'CnQ + ';
    if (ac = 0) then
    strac := ''
    else
    strac := formatfloat ('0.00', ac);

    Resultado.Caption:= coefcarbono+coefhidrogenio+coefnitrogenio+coefenxofre+
    coefoxigenio+coefucomb+coefar+' ---> '+coefco2+coefcnq+coefco+coefh2o+
    coefso2+coefo2+coefn2   ;


    if (aux1 <> 0) then
    Resultado2.Caption:= 'Relação Ar/Combustivel = '+strac;




    end

    /////// fi  > 1 para massico
    else if (qfi > 1) then
        begin

    aux := qcnq/12;
    if (radiocnq.Itemindex = 0) then
    qcnq := ((aux/100)*qcinza)/(1-(aux/100))
    else if (radiocnq.ItemIndex = 1) then
    qcnq := qcnq*(qcarbono + qnitrogenio + qenxofre + qucomb + qoxigenio +
    qhidrogenio + qcinza)/12;

    qcarbono := qcarbono/12 ;
    qnitrogenio := qnitrogenio/14  ;
    qenxofre:= qenxofre/32;
    qucomb := qucomb/18;
    qoxigenio := qoxigenio/16;
    //ninjice de joao (joaozice)
    qco2 := qcarbono - qcnq;
    qso2:= qenxofre;
    qar :=  qfi*((qso2)+(qhidrogenio/4)+(qco2)-(qoxigenio/2));
    qh2o := (qhidrogenio/2+ qucomb + qar*(quar*137.28/18)) ;  //otra ninjice
    qn2 := (qnitrogenio/2 + qar*3.76) ;
    qo2 := qcnq + (qar/qfi)*(qfi-1);
    qco := 0;

      if (radioac.itemindex = 0 ) then
        begin
           aux1 := (qcarbono*12 + qhidrogenio + qnitrogenio*14 + qenxofre*32 +
           qoxigenio*16 + qcinza + qucomb*18);
         if (aux1 = 0) then
          resultado2.Caption:= 'Não há combustivel ou ar'
         else
            ac := qar*(137.28 + quar*137.28)/(qcarbono*12 + qhidrogenio +
            qnitrogenio*14 + qenxofre*32 + qoxigenio*16 + qcinza + qucomb*18);
         end

      else if (radioac.ItemIndex = 1) then
        begin
          aux1:= (qcarbono + qhidrogenio + qnitrogenio + qenxofre +
          qoxigenio + qucomb);
          if (aux1 = 0) then
           resultado2.caption:= 'Não há combustivel ou ar'
          else
            ac := qar*(4.76 + quar/18); // /
            //(qcarbono + qhidrogenio + qnitrogenio +
          //  qenxofre + qoxigenio + qucomb);
          end;


 /////inicio da pog do resultado 3 /////

        if (radiogas.ItemIndex = 0) then
          begin
           aux3 := (qco2 + qco + qso2 + qo2 + qn2);
            if (aux3 <> 0) then
              begin
               pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2));
               pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2));
               pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2));
               po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2));
               pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2));
               sph2o := '';
              if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
            end;
          end

        else if (radiogas.itemindex = 1) then
          begin
          aux3 := (qco2 + qco + qso2 + qo2 + qn2 + qh2o);
           if (aux3 <> 0) then
            begin
            pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            ph2o := 100*(qh2o/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
               if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
               if (ph2o = 0) then
                  sph2o := ''
               else
                  sph2o := formatfloat ('0.00', ph2o)+'%H2O ';
            end;
          end;


   if (aux3 <> 0 ) then
   resultado3.Caption := 'Analise dos gases: '+spco2+spco+spo2+sph2o+spso2+spn2
   else if (aux3 = 0) then
    resultado3.Caption:= 'Não há produtos de combustão';

        //// fim da pog dos gas

    if (qcarbono = 0) then
    coefcarbono := ''
    else
    coefcarbono := formatfloat ('0.00', qcarbono)+'C + ';
    if  (qhidrogenio = 0) then
    coefhidrogenio := ''
    else
    coefhidrogenio := formatfloat ('0.00', qhidrogenio)+'H + ';
    if (qnitrogenio = 0) then
    coefnitrogenio := ''
    else
    coefnitrogenio := formatfloat ('0.00', qnitrogenio)+'N + ';
    if (qoxigenio = 0) then
    coefoxigenio := ''
    else
    coefoxigenio := formatfloat ('0.00', qoxigenio)+'O + ';
    if (qenxofre = 0) then
    coefenxofre := ''
    else
    coefenxofre := formatfloat ('0.00', qenxofre)+'S + ';
    if (qucomb = 0) then
    coefucomb := ''
    else
    coefucomb := formatfloat ('0.00', qucomb)+'H2O + ';
    if (qar = 0) then
    coefar := ''
    else
    if (quar = 0) then
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2)'
    else
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2 + '+
    formatfloat ('0.00',(quar*137.28/18))+'H2O)';
    if (qco2 = 0) then
    coefco2 := ''
    else
    coefco2 := formatfloat ('0.00', qco2)+'CO2 + ';
    if (qh2o = 0) then
    coefh2o := ''
    else
    coefh2o := formatfloat ('0.00', qh2o)+'H2O + ';
    if (qso2 = 0) then
    coefso2 := ''
    else
    coefso2 := formatfloat ('0.00', qso2)+'SO2 + ';
    if (qn2 = 0) then
    coefn2 := ''
    else
    coefn2 := formatfloat ('0.00', qn2)+'N2';
    if (qco = 0) then
    coefco := ''
    else
    coefco := formatfloat ('0.00', qco)+'CO + ';
    if (qo2 = 0) then
    coefo2 :=''
    else
    coefo2 := formatfloat ('0.00', qo2)+'O2 + ';
    if (qcnq = 0) then
    coefcnq := ''
    else
    coefcnq := formatfloat ('0.00', qcnq)+'CnQ + ';
    if (ac = 0) then
    strac := ''
    else
    strac := formatfloat ('0.00', ac);

    Resultado.Caption:= coefcarbono+coefhidrogenio+coefnitrogenio+coefenxofre+
    coefoxigenio+coefucomb+coefar+' ---> '+coefco2+coefcnq+coefco+coefh2o+
    coefso2+coefo2+coefn2   ;

    if (aux1 <> 0) then
    Resultado2.Caption:= 'Relação Ar/Combustivel = '+strac;

   //isto é um comentario e não será executado nunca
    end
   else if (qfi <1) then
           begin

    aux := qcnq/12;
    if (radiocnq.Itemindex = 0) then
    qcnq := ((aux/100)*qcinza)/(1-(aux/100))
    else if (radiocnq.ItemIndex = 1) then
    qcnq := qcnq*(qcarbono + qnitrogenio + qenxofre + qucomb + qoxigenio +
    qhidrogenio + qcinza);

    qcarbono := qcarbono/12 ;
    qnitrogenio := qnitrogenio/14  ;
    qenxofre:= qenxofre/32;
    qucomb := qucomb/18;
    qoxigenio := qoxigenio/16;
    //ninjice de joao (joaozice)
    qar :=  qfi*((qenxofre)+(qhidrogenio/4)+(qcarbono)-(qoxigenio/2));
    qh2o := ( qhidrogenio/2+ qucomb + qar*(quar*137.28/18 )) ;
    qo:= qoxigenio + qar*2 - qhidrogenio/2 - 2*qenxofre ;
    qso2:= qenxofre;
    qn2 := (qnitrogenio/2 + qar*3.76) ;
    qo2 := 0; //qcnq + qar*(qfi-1);
    if ( qo >= qcarbono) then
      begin
        qco2 := 2*(qo - qcarbono);
        qco := qcarbono - qco2;
      end
    else
      begin
        qco := (qcarbono - qo);
        qco2 := 0;
      end;

   if (radioac.itemindex = 0 ) then
        begin
           aux1 := (qcarbono*12 + qhidrogenio + qnitrogenio*14 + qenxofre*32 +
           qoxigenio*16 + qcinza + qucomb*18);
         if (aux1 = 0) then
          resultado2.Caption:= 'Não há combustivel ou ar'
         else
            ac := qar*(137.28 + quar*137.28)/(qcarbono*12 + qhidrogenio +
            qnitrogenio*14 + qenxofre*32 + qoxigenio*16 + qcinza + qucomb*18);
         end

      else if (radioac.ItemIndex = 1) then
        begin
          aux1:= (qcarbono + qhidrogenio + qnitrogenio + qenxofre +
          qoxigenio + qucomb);
          if (aux1 = 0) then
           resultado2.caption:= 'Não há combustivel ou ar'
          else
            ac := qar*(4.76 + quar );
            // (qcarbono + qhidrogenio + qnitrogenio + qenxofre +
            //qoxigenio + qucomb);
          end;


  /////inicio da pog do resultado 3 /////

        if (radiogas.ItemIndex = 0) then
          begin
           aux3 := (qco2 + qco + qso2 + qo2 + qn2);
            if (aux3 <> 0) then
              begin
               pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2));
               pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2));
               pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2));
               po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2));
               pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2));
               sph2o := '';
              if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
            end;
          end

        else if (radiogas.itemindex = 1) then
          begin
          aux3 := (qco2 + qco + qso2 + qo2 + qn2 + qh2o);
           if (aux3 <> 0) then
            begin
            pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            ph2o := 100*(qh2o/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
               if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
               if (ph2o = 0) then
                  sph2o := ''
               else
                  sph2o := formatfloat ('0.00', ph2o)+'%H2O ';
            end;
          end;


   if (aux3 <> 0 ) then
   resultado3.Caption := 'Analise dos gases: '+spco2+spco+spo2+sph2o+spso2+spn2
   else if (aux3 = 0) then
    resultado3.Caption:= 'Não há produtos de combustão';

        //// fim da pog dos gas

    if (qcarbono = 0) then
    coefcarbono := ''
    else
    coefcarbono := formatfloat ('0.00', qcarbono)+'C + ';
    if  (qhidrogenio = 0) then
    coefhidrogenio := ''
    else
    coefhidrogenio := formatfloat ('0.00', qhidrogenio)+'H + ';
    if (qnitrogenio = 0) then
    coefnitrogenio := ''
    else
    coefnitrogenio := formatfloat ('0.00', qnitrogenio)+'N + ';
    if (qoxigenio = 0) then
    coefoxigenio := ''
    else
    coefoxigenio := formatfloat ('0.00', qoxigenio)+'O + ';
    if (qenxofre = 0) then
    coefenxofre := ''
    else
    coefenxofre := formatfloat ('0.00', qenxofre)+'S + ';
    if (qucomb = 0) then
    coefucomb := ''
    else
    coefucomb := formatfloat ('0.00', qucomb)+'H2O + ';
    if (qar = 0) then
    coefar := ''
    else
    if (quar = 0) then
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2)'
    else
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2 + '+
    formatfloat ('0.00',(quar*137.28/18))+'H2O)';
    if (qco2 = 0) then
    coefco2 := ''
    else
    coefco2 := formatfloat ('0.00', qco2)+'CO2 + ';
    if (qh2o = 0) then
    coefh2o := ''
    else
    coefh2o := formatfloat ('0.00', qh2o)+'H2O + ';
    if (qso2 = 0) then
    coefso2 := ''
    else
    coefso2 := formatfloat ('0.00', qso2)+'SO2 + ';
    if (qn2 = 0) then
    coefn2 := ''
    else
    coefn2 := formatfloat ('0.00', qn2)+'N2';
    if (qco = 0) then
    coefco := ''
    else
    coefco := formatfloat ('0.00', qco)+'CO + ';
    if (qo2 = 0) then
    coefo2 :=''
    else
    coefo2 := formatfloat ('0.00', qo2)+'O2 + ';
    if (qcnq = 0) then
    coefcnq := ''
    else
    coefcnq := formatfloat ('0.00', qcnq)+'CnQ + ';
    if (ac = 0) then
    strac := ''
    else
    strac := formatfloat ('0.00', ac);


    Resultado.Caption:= coefcarbono+coefhidrogenio+coefnitrogenio+coefenxofre+
    coefoxigenio+coefucomb+coefar+' ---> '+coefco2+coefcnq+coefco+coefh2o+
    coefso2+coefo2+coefn2   ;

    if (aux1 <> 0) then
    Resultado2.Caption:= 'Relação Ar/Combustivel = '+strac;

   //isto é um comentario e não será executado nunca
    end;
 end ;

  ////////////  //////Aki começa o baguio em molar\\\\\\\\   \\\\\\\\\\\\\\\
 if (radiotipo.ItemIndex = 1) then //inicio do calculo base molar

    begin

    if (qfi = 1) then
        begin

    aux := qcnq/12;
    if (radiocnq.Itemindex = 0) then
    qcnq := ((aux/100)*qcinza)/(1-(aux/100))
    else if (radiocnq.ItemIndex = 1) then
    qcnq := qcnq*(qcarbono + qnitrogenio + qenxofre + qucomb + qoxigenio +
    qhidrogenio);


    //ninjice de joao (joaozice)
    qar :=  (qenxofre)+(qhidrogenio/4)+(qcarbono)-(qoxigenio/2);
    qco2 := qcarbono - qcnq;
    qso2:= qenxofre;
    qh2o := (qhidrogenio/2+ qucomb + qar*(quar*137.28/18)) ;  //otra ninjice
    qn2 :=  (qnitrogenio/2 + qar*3.76) ;
    qo2 := qcnq ;
    qco := 0;


      if (radioac.itemindex = 0 ) then
        begin
           aux1 := (qcarbono*12 + qhidrogenio + qnitrogenio*14 + qenxofre*32 +
           qoxigenio*16 + qcinza + qucomb*18);
         if (aux1 = 0) then
          resultado2.Caption:= 'Não há combustivel ou ar'
         else
            ac := qar*(137.28 + quar*137.28)/(qcarbono*12 + qhidrogenio +
            qnitrogenio*14 + qenxofre*32 + qoxigenio*16 + qcinza + qucomb*18);
         end

      else if (radioac.ItemIndex = 1) then
        begin
          aux1:= (qcarbono + qhidrogenio + qnitrogenio + qenxofre +
          qoxigenio + qucomb);
          if (aux1 = 0) then
           resultado2.caption:= 'Não há combustivel ou ar'
          else
            ac := qar*(4.76 + quar );/// (qcarbono + qhidrogenio + qnitrogenio +
            //qenxofre + qoxigenio + qucomb);
          end;


  /////inicio da pog do resultado 3 /////

        if (radiogas.ItemIndex = 0) then
          begin
           aux3 := (qco2 + qco + qso2 + qo2 + qn2);
            if (aux3 <> 0) then
              begin
               pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2));
               pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2));
               pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2));
               po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2));
               pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2));
               sph2o := '';
              if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
            end;
          end

        else if (radiogas.itemindex = 1) then
          begin
          aux3 := (qco2 + qco + qso2 + qo2 + qn2 + qh2o);
           if (aux3 <> 0) then
            begin
            pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            ph2o := 100*(qh2o/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
               if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
               if (ph2o = 0) then
                  sph2o := ''
               else
                  sph2o := formatfloat ('0.00', ph2o)+'%H2O ';
            end;
          end;


   if (aux3 <> 0 ) then
   resultado3.Caption := 'Analise dos gases: '+spco2+spco+spo2+sph2o+spso2+spn2
   else if (aux3 = 0) then
    resultado3.Caption:= 'Não há produtos de combustão';

        //// fim da pog dos gas


    if (qcarbono = 0) then
    coefcarbono := ''
    else
    coefcarbono := formatfloat ('0.00', qcarbono)+'C + ';
    if  (qhidrogenio = 0) then
    coefhidrogenio := ''
    else
    coefhidrogenio := formatfloat ('0.00', qhidrogenio)+'H + ';
    if (qnitrogenio = 0) then
    coefnitrogenio := ''
    else
    coefnitrogenio := formatfloat ('0.00', qnitrogenio)+'N + ';
    if (qoxigenio = 0) then
    coefoxigenio := ''
    else
    coefoxigenio := formatfloat ('0.00', qoxigenio)+'O + ';
    if (qenxofre = 0) then
    coefenxofre := ''
    else
    coefenxofre := formatfloat ('0.00', qenxofre)+'S + ';
    if (qucomb = 0) then
    coefucomb := ''
    else
    coefucomb := formatfloat ('0.00', qucomb)+'H2O + ';
    if (qar = 0) then
    coefar := ''
    else
    if (quar = 0) then
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2)'
    else
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2 + '+
    formatfloat ('0.00',(quar*137.28/18))+'H2O)';
    if (qco2 = 0) then
    coefco2 := ''
    else
    coefco2 := formatfloat ('0.00', qco2)+'CO2 + ';
    if (qh2o = 0) then
    coefh2o := ''
    else
    coefh2o := formatfloat ('0.00', qh2o)+'H2O + ';
    if (qso2 = 0) then
    coefso2 := ''
    else
    coefso2 := formatfloat ('0.00', qso2)+'SO2 + ';
    if (qn2 = 0) then
    coefn2 := ''
    else
    coefn2 := formatfloat ('0.00', qn2)+'N2';
    if (qco = 0) then
    coefco := ''
    else
    coefco := formatfloat ('0.00', qco)+'CO + ';
    if (qo2 = 0) then
    coefo2 :=''
    else
    coefo2 := formatfloat ('0.00', qo2)+'O2 + ';
    if (qcnq = 0) then
    coefcnq := ''
    else
    coefcnq := formatfloat ('0.00', qcnq)+'CnQ + ';
    if (ac = 0) then
    strac := ''
    else
    strac := formatfloat ('0.00', ac);

    Resultado.Caption:= coefcarbono+coefhidrogenio+coefnitrogenio+coefenxofre+
    coefoxigenio+coefucomb+coefar+' ---> '+coefco2+coefcnq+coefco+coefh2o+
    coefso2+coefo2+coefn2   ;


    if (aux1 <> 0) then
    Resultado2.Caption:= 'Relação Ar/Combustivel = '+strac;




    end

    /////// fi  > 1 para molar
    else if (qfi > 1) then
        begin

    aux := qcnq/12;
    if (radiocnq.Itemindex = 0) then
    qcnq := ((aux/100)*qcinza)/(1-(aux/100))
    else if (radiocnq.ItemIndex = 1) then
    qcnq := qcnq*(qcarbono + qnitrogenio + qenxofre + qucomb + qoxigenio +
    qhidrogenio);

    //ninjice de joao (joaozice)
    qar :=  qfi*((qenxofre)+(qhidrogenio/4)+(qcarbono)-(qoxigenio/2));
    qco2 := qcarbono - qcnq;
    qso2:= qenxofre;
    qh2o := (qhidrogenio/2+ qucomb + qar*(quar*137.28/18)) ;  //otra ninjice
    qn2 := (qnitrogenio/2 + qar*3.76) ;
    qo2 := qcnq + (qar/qfi)*(qfi-1);
    qco := 0;

     if (radioac.itemindex = 0 ) then
        begin
           aux1 := (qcarbono*12 + qhidrogenio + qnitrogenio*14 + qenxofre*32 +
           qoxigenio*16 + qcinza + qucomb*18);
         if (aux1 = 0) then
          resultado2.Caption:= 'Não há combustivel ou ar'
         else
            ac := qar*(137.28 + quar*137.28)/(qcarbono*12 + qhidrogenio +
            qnitrogenio*14 + qenxofre*32 + qoxigenio*16 + qcinza + qucomb*18);
         end

      else if (radioac.ItemIndex = 1) then
        begin
          aux1:= (qcarbono + qhidrogenio + qnitrogenio + qenxofre +
          qoxigenio + qucomb);
          if (aux1 = 0) then
           resultado2.caption:= 'Não há combustivel ou ar'
          else
            ac := qar*(4.76 + quar); /// (qcarbono + qhidrogenio + qnitrogenio +
        //    qenxofre + qoxigenio + qucomb);
          end;
    
  /////inicio da pog do resultado 3 /////

        if (radiogas.ItemIndex = 0) then
          begin
           aux3 := (qco2 + qco + qso2 + qo2 + qn2);
            if (aux3 <> 0) then
              begin
               pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2));
               pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2));
               pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2));
               po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2));
               pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2));
               sph2o := '';
              if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
            end;
          end

        else if (radiogas.itemindex = 1) then
          begin
          aux3 := (qco2 + qco + qso2 + qo2 + qn2 + qh2o);
           if (aux3 <> 0) then
            begin
            pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            ph2o := 100*(qh2o/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
               if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
               if (ph2o = 0) then
                  sph2o := ''
               else
                  sph2o := formatfloat ('0.00', ph2o)+'%H2O ';
            end;
          end;


   if (aux3 <> 0 ) then
   resultado3.Caption := 'Analise dos gases: '+spco2+spco+spo2+sph2o+spso2+spn2
   else if (aux3 = 0) then
    resultado3.Caption:= 'Não há produtos de combustão';

        //// fim da pog dos gas

    if (qcarbono = 0) then
    coefcarbono := ''
    else
    coefcarbono := formatfloat ('0.00', qcarbono)+'C + ';
    if  (qhidrogenio = 0) then
    coefhidrogenio := ''
    else
    coefhidrogenio := formatfloat ('0.00', qhidrogenio)+'H + ';
    if (qnitrogenio = 0) then
    coefnitrogenio := ''
    else
    coefnitrogenio := formatfloat ('0.00', qnitrogenio)+'N + ';
    if (qoxigenio = 0) then
    coefoxigenio := ''
    else
    coefoxigenio := formatfloat ('0.00', qoxigenio)+'O + ';
    if (qenxofre = 0) then
    coefenxofre := ''
    else
    coefenxofre := formatfloat ('0.00', qenxofre)+'S + ';
    if (qucomb = 0) then
    coefucomb := ''
    else
    coefucomb := formatfloat ('0.00', qucomb)+'H2O + ';
    if (qar = 0) then
    coefar := ''
    else
    if (quar = 0) then
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2)'
    else
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2 + '+
    formatfloat ('0.00',(quar*137.28/18))+'H2O)';
    if (qco2 = 0) then
    coefco2 := ''
    else
    coefco2 := formatfloat ('0.00', qco2)+'CO2 + ';
    if (qh2o = 0) then
    coefh2o := ''
    else
    coefh2o := formatfloat ('0.00', qh2o)+'H2O + ';
    if (qso2 = 0) then
    coefso2 := ''
    else
    coefso2 := formatfloat ('0.00', qso2)+'SO2 + ';
    if (qn2 = 0) then
    coefn2 := ''
    else
    coefn2 := formatfloat ('0.00', qn2)+'N2';
    if (qco = 0) then
    coefco := ''
    else
    coefco := formatfloat ('0.00', qco)+'CO + ';
    if (qo2 = 0) then
    coefo2 :=''
    else
    coefo2 := formatfloat ('0.00', qo2)+'O2 + ';
    if (qcnq = 0) then
    coefcnq := ''
    else
    coefcnq := formatfloat ('0.00', qcnq)+'CnQ + ';
    if (ac = 0) then
    strac := ''
    else
    strac := formatfloat ('0.00', ac);

    Resultado.Caption:= coefcarbono+coefhidrogenio+coefnitrogenio+coefenxofre+
    coefoxigenio+coefucomb+coefar+' ---> '+coefco2+coefcnq+coefco+coefh2o+
    coefso2+coefo2+coefn2   ;

   if (aux1 <> 0) then
    Resultado2.Caption:= 'Relação Ar/Combustivel = '+strac;

   //isto é um comentario e não será executado nunca
    end
   else if (qfi <1) then
           begin

    aux := qcnq/12;
    if (radiocnq.Itemindex = 0) then
    qcnq := ((aux/100)*qcinza)/(1-(aux/100))
    else if (radiocnq.ItemIndex = 1) then
    qcnq := qcnq*(qcarbono + qnitrogenio + qenxofre + qucomb + qoxigenio +
    qhidrogenio);


    //ninjice de joao (joaozice)
    qar :=  qfi*((qenxofre)+(qhidrogenio/4)+(qcarbono)-(qoxigenio/2));
    qh2o := ( qhidrogenio/2+ qucomb + qar*(quar*137.28/18 )) ;
    qo:= qoxigenio + (qar*2) - (qhidrogenio/2) - (2*qenxofre) ;
    qso2:= qenxofre;
    qn2 := (qnitrogenio/2 + qar*3.76) ;
    qo2 := 0; //qcnq + qar*(qfi-1);
     if ( qo >= qcarbono) then
       begin
         qco2 := qo - qcarbono;
         qco := qcarbono - qco2;
       end
     else
       begin
         qco := 2*(qcarbono - qo);
         qco2 := 0;
       end;
    if (radioac.itemindex = 0 ) then
        begin
           aux1 := (qcarbono*12 + qhidrogenio + qnitrogenio*14 + qenxofre*32 +
           qoxigenio*16 + qcinza + qucomb*18);
         if (aux1 = 0) then
          resultado2.Caption:= 'Não há combustivel ou ar'
         else
            ac := qar*(137.28 + quar*137.28)/(qcarbono*12 + qhidrogenio +
            qnitrogenio*14 + qenxofre*32 + qoxigenio*16 + qcinza + qucomb*18);
         end

      else if (radioac.ItemIndex = 1) then
        begin
          aux1:= (qcarbono + qhidrogenio + qnitrogenio + qenxofre +
          qoxigenio + qucomb);
          if (aux1 = 0) then
           resultado2.caption:= 'Não há combustivel ou ar'
          else
            ac := qar*(4.76 + quar/18);
            //ac := qar / (qcarbono + qhidrogenio + qnitrogenio + qenxofre +
           // qoxigenio + qucomb);
          end;


  /////inicio da pog do resultado 3 /////

        if (radiogas.ItemIndex = 0) then
          begin
           aux3 := (qco2 + qco + qso2 + qo2 + qn2);
            if (aux3 <> 0) then
              begin
               pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2));
               pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2));
               pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2));
               po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2));
               pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2));
               sph2o := '';
              if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
            end;
          end

        else if (radiogas.itemindex = 1) then
          begin
          aux3 := (qco2 + qco + qso2 + qo2 + qn2 + qh2o);
           if (aux3 <> 0) then
            begin
            pco2 := 100*(qco2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pco := 100*(qco/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pso2 := 100*(qso2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            po2 := 100*(qo2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            pn2 := 100*(qn2/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
            ph2o := 100*(qh2o/ (qco2 + qco + qso2 + qo2 + qn2 + qh2o));
               if (pco2 = 0) then
                  spco2 := ''
               else
                  spco2 := formatfloat ('0.00', pco2)+'%CO2 ' ;
               if (pco = 0) then
                  spco := ''
               else
                  spco := formatfloat ('0.00', pco)+'%CO ';
               if (pso2 = 0) then
                  spso2 := ''
               else
                  spso2 := formatfloat ('0.00', pso2)+'%SO2 ';
               if (po2 = 0) then
                  spo2 := ''
               else
                  spo2 := formatfloat ('0.00', po2)+'%O2 ';
               if (pn2 = 0) then
                  spn2 := ''
               else
                  spn2 := formatfloat ('0.00', pn2)+'%N2';
               if (ph2o = 0) then
                  sph2o := ''
               else
                  sph2o := formatfloat ('0.00', ph2o)+'%H2O ';
            end;
          end;


   if (aux3 <> 0 ) then
   resultado3.Caption := 'Analise dos gases: '+spco2+spco+spo2+sph2o+spso2+spn2
   else if (aux3 = 0) then
    resultado3.Caption:= 'Não há produtos de combustão';

        //// fim da pog dos gas

    if (qcarbono = 0) then
    coefcarbono := ''
    else
    coefcarbono := formatfloat ('0.00', qcarbono)+'C + ';
    if  (qhidrogenio = 0) then
    coefhidrogenio := ''
    else
    coefhidrogenio := formatfloat ('0.00', qhidrogenio)+'H + ';
    if (qnitrogenio = 0) then
    coefnitrogenio := ''
    else
    coefnitrogenio := formatfloat ('0.00', qnitrogenio)+'N + ';
    if (qoxigenio = 0) then
    coefoxigenio := ''
    else
    coefoxigenio := formatfloat ('0.00', qoxigenio)+'O + ';
    if (qenxofre = 0) then
    coefenxofre := ''
    else
    coefenxofre := formatfloat ('0.00', qenxofre)+'S + ';
    if (qucomb = 0) then
    coefucomb := ''
    else
    coefucomb := formatfloat ('0.00', qucomb)+'H2O + ';
    if (qar = 0) then
    coefar := ''
    else
    if (quar = 0) then
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2)'
    else
    coefar := formatfloat ('0.00', qar)+'(O2 + 3,76N2 + '+
    formatfloat ('0.00',(quar*137.28/18))+'H2O)';
    if (qco2 = 0) then
    coefco2 := ''
    else
    coefco2 := formatfloat ('0.00', qco2)+'CO2 + ';
    if (qh2o = 0) then
    coefh2o := ''
    else
    coefh2o := formatfloat ('0.00', qh2o)+'H2O + ';
    if (qso2 = 0) then
    coefso2 := ''
    else
    coefso2 := formatfloat ('0.00', qso2)+'SO2 + ';
    if (qn2 = 0) then
    coefn2 := ''
    else
    coefn2 := formatfloat ('0.00', qn2)+'N2';
    if (qco = 0) then
    coefco := ''
    else
    coefco := formatfloat ('0.00', qco)+'CO + ';
    if (qo2 = 0) then
    coefo2 :=''
    else
    coefo2 := formatfloat ('0.00', qo2)+'O2 + ';
    if (qcnq = 0) then
    coefcnq := ''
    else
    coefcnq := formatfloat ('0.00', qcnq)+'CnQ + ';
    if (ac = 0) then
    strac := ''
    else
    strac := formatfloat ('0.00', ac);


    Resultado.Caption:= coefcarbono+coefhidrogenio+coefnitrogenio+coefenxofre+
    coefoxigenio+coefucomb+coefar+' ---> '+coefco2+coefcnq+coefco+coefh2o+
    coefso2+coefo2+coefn2   ;

    if (aux1 <> 0) then
    Resultado2.Caption:= 'Relação Ar/Combustivel = '+strac;

   //isto é um comentario e não será executado nunca
    end;

 end ;


//if novo aki

// if (radiotipo.ItemIndex = 2) then
// begin

//
//  end;



end;


procedure TForm1.radiotipoClick(Sender: TObject);
begin
  if radiotipo.ItemIndex = 0 then
    begin
      d:=1;

While d<14 do
 begin
  ListBox1.ItemIndex:=0;
  ListBox2.ItemIndex:=0;
  ListBox1.Items.Delete(ListBox1.ItemIndex);
  ListBox2.Items.Delete(ListBox2.ItemIndex);
  d:=d+1;
 end   ;
      btbalancear.enabled:= true;
      Button1.enabled:=false;
      button2.enabled:=false;
      edcarb.Enabled:= true;
      edcinza.enabled:=true;
      edcnq.enabled:=true;
      edenxofre.enabled:=true;
      edfi.enabled:=true;
      edhidrogenio.enabled:=true;
      ednitrogenio.enabled:=true;
      edoxigenio.enabled:=true;
      eduar.enabled:=true;
      educomb.enabled:=true;
      radiocnq.enabled:=true;
      radioac.enabled:=true;
      radiogas.enabled:=true;
    end;
  if radiotipo.ItemIndex = 1 then
    begin
    d:=1;

While d<14 do
 begin
  ListBox1.ItemIndex:=0;
  ListBox2.ItemIndex:=0;
  ListBox1.Items.Delete(ListBox1.ItemIndex);
  ListBox2.Items.Delete(ListBox2.ItemIndex);
  d:=d+1;
 end   ;
      btbalancear.enabled:= true;
      Button1.enabled:=false;
      button2.enabled:=false;
      edcarb.Enabled:= true;
      edcinza.enabled:=true;
      edcnq.enabled:=true;
      edenxofre.enabled:=true;
      edfi.enabled:=true;
      edhidrogenio.enabled:=true;
      ednitrogenio.enabled:=true;
      edoxigenio.enabled:=true;
      eduar.enabled:=true;
      educomb.enabled:=true;
      radiocnq.enabled:=true;
      radioac.enabled:=true;
      radiogas.enabled:=true;
    end;
  if radiotipo.ItemIndex = 2 then
    begin
      btbalancear.enabled:= false;
      
      edcarb.Enabled:= false;
      edcinza.enabled:=false;
      edcnq.enabled:=false;
      edenxofre.enabled:=false;
      edfi.enabled:=false;
      edhidrogenio.enabled:=false;
      ednitrogenio.enabled:=false;
      edoxigenio.enabled:=false;
      eduar.enabled:=false;
      educomb.enabled:=false;
      radiocnq.enabled:=false;
      radioac.enabled:=true;
      radiogas.enabled:=true;
    end;
end;

procedure TForm1.radiodoscombustivelClick(Sender: TObject);
begin
   Button1.enabled:=true;
   button2.enabled:= false;
   form3.Chart1.Series[0].clear;
                d:=1;

                While d<14 do
                  begin
                   ListBox1.ItemIndex:=0;
                   ListBox2.ItemIndex:=0;
                   ListBox1.Items.Delete(ListBox1.ItemIndex);
                   ListBox2.Items.Delete(ListBox2.ItemIndex);
                   d:=d+1;
                  end ;
      //t0 := 1500;
    
     if radiodoscombustivel.ItemIndex = 0 then      //metano
        begin
              edcarb.text:= '1';
              edhidrogenio.text := '4';
              edoxigenio.text :=  '';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;



             // Resultadoenergia:= formatfloat ('0.00',

        end;

      if radiodoscombustivel.ItemIndex = 1 then      //acetileno
        begin
              edcarb.text:= '2';
              edhidrogenio.text := '2';
              edoxigenio.text := '';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

         if radiodoscombustivel.ItemIndex = 2 then      //etileno
        begin
              edcarb.text:= '2';
              edhidrogenio.text := '2';
              edoxigenio.text := '';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

           if radiodoscombustivel.ItemIndex = 3 then      //etano
        begin
              edcarb.text:= '2';
              edhidrogenio.text := '6';
              edoxigenio.text := '';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

           if radiodoscombustivel.ItemIndex = 4 then      //propileno
        begin
              edcarb.text:= '3';
              edhidrogenio.text := '6';
              edoxigenio.text := '';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

         if radiodoscombustivel.ItemIndex = 5 then      //propano
        begin
              edcarb.text:= '3';
              edhidrogenio.text := '8';
              edoxigenio.text := '';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

           if radiodoscombustivel.ItemIndex = 6 then      //butano
        begin
              edcarb.text:= '4';
              edhidrogenio.text := '10';
              edoxigenio.text := '';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

           if radiodoscombustivel.ItemIndex = 7 then      //pentano
        begin
              edcarb.text:= '5';
              edhidrogenio.text := '12';
              edoxigenio.text := '';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

           if radiodoscombustivel.ItemIndex = 8 then      //octano
        begin
              edcarb.text:= '8';
              edhidrogenio.text := '18';
              edoxigenio.text := '';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

       if radiodoscombustivel.ItemIndex = 9 then      //octano  liquido
        begin
              edcarb.text:= '8';
              edhidrogenio.text := '18';
              edoxigenio.text := '';
              ednitrogenio.text := '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

           if radiodoscombustivel.ItemIndex = 10 then      //benzeno
        begin
              edcarb.text:= '6';
              edhidrogenio.text := '6';
              edoxigenio.text := '';
              ednitrogenio.text := '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

           if radiodoscombustivel.ItemIndex = 11 then      //alcool metilico
        begin
              edcarb.text:= '1';
              edhidrogenio.text := '4';
              edoxigenio.text := '1';
              ednitrogenio.text := '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

             if radiodoscombustivel.ItemIndex = 12 then      //alcool metilico l
        begin
              edcarb.text:= '1';
              edhidrogenio.text := '4';
              edoxigenio.text := '1';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

           if radiodoscombustivel.ItemIndex = 13 then      //alcool etilico
        begin
              edcarb.text:= '2';
              edhidrogenio.text := '6';
              edoxigenio.text := '1';
              ednitrogenio.text := '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;

          if radiodoscombustivel.ItemIndex = 14 then      //alcool etilico l
        begin
              edcarb.text:= '2';
              edhidrogenio.text := '6';
              edoxigenio.text := '1';
              ednitrogenio.text:= '';
              edenxofre.text := '';
              radiotipo.ItemIndex := 1;
              btbalancear.click;
              radiotipo.itemindex := 2;
              Button1.enabled:=true;
        end;



end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  button2.Enabled:= true;
  radioac.enabled:=false;
  radiogas.enabled:=false;
d:=1;
While d<14 do
 begin
  ListBox1.ItemIndex:=0;
  ListBox2.ItemIndex:=0;
  ListBox1.Items.Delete(ListBox1.ItemIndex);
  ListBox2.Items.Delete(ListBox2.ItemIndex);
  d:=d+1;
 end   ;

      if radiodoscombustivel.itemindex = -1 then
      begin
Messagedlg('Selecione o Combustível antes de proceder ao balanço energético',mtwarning,[mbok],0);
      end;

  //Aki começa todo balanço energetico

  {! precisa ser corrigido //EXISTE UM ERRO NO LOOPING !} {* -.- *}

if radiodoscombustivel.itemindex = 0  then
  begin
    x:=1;y:=4;z:=0;hf:=-74850;
  end;

if radiodoscombustivel.itemindex = 1 then
  begin
    x:=2;y:=2;z:=0;hf:=226730;
  end;

if radiodoscombustivel.itemindex = 2 then
  begin
    x:=2;y:=2;z:=0;hf:=52280;
  end;

if radiodoscombustivel.itemindex = 3 then
  begin
    x:=2;y:=6;z:=0;hf:=-84680;
  end;

if radiodoscombustivel.itemindex = 4 then
  begin
    x:=3;y:=6;z:=0;hf:=20410;
  end;

if radiodoscombustivel.itemindex = 5 then
  begin
    x:=3;y:=8;z:=0;hf:=-103850;
  end;

if radiodoscombustivel.itemindex = 6 then
  begin
    x:=4;y:=10;z:=0;hf:=-126150;
  end;

if radiodoscombustivel.itemindex = 7 then
  begin
    x:=5;y:=12;z:=0;hf:=-146440;
  end;

if radiodoscombustivel.itemindex = 8 then
  begin
    x:=8;y:=18;z:=0;hf:=-208450;
  end;

if radiodoscombustivel.itemindex = 9 then
  begin
    x:=8;y:=18;z:=0;hf:=-249910;
  end;

if radiodoscombustivel.itemindex = 10 then
  begin
    x:=6;y:=6;z:=0;hf:=82930;
  end;

if radiodoscombustivel.itemindex = 11 then
  begin
    x:=1;y:=4;z:=1;hf:=-200890;
  end;

if radiodoscombustivel.itemindex = 12 then
  begin
    x:=1;y:=4;z:=1;hf:=-238810;
  end;

if radiodoscombustivel.itemindex = 13 then
  begin
    x:=2;y:=6;z:=1;hf:=-235310;
  end;

if radiodoscombustivel.itemindex = 14 then
  begin
    x:=2;y:=6;z:=1;hf:=-277690;
  end;

hf1:=-393520; hf2:=-241820; hf3:=0; hf4:=-110530; hf5:=0;
b11:=66.27; b12:=68.58; c11:=-11634; c12:=-16979;
b21:=49.36; b22:=60.43; c21:=-7940.8; c22:=-19212;
b31:=37.46; b32:=39.32; c31:=-4559.3; c32:=-6753.4;
b41:=37.85; b42:=39.29; c41:=-4571.9; c42:=-6201.9;
b51:=42.27; b52:=46.25; c51:=-6635.4; c52:=-18798;
  f:=0.8;
While f<=2 do

  begin



    If f<1 then
     begin

      for i:=1 to 2 do
      begin
       L[i]:=z+f*(2*x+y/2-z)-y/2-x;
       M[i]:=(y/2);
       N[i]:=(f*3.72*(2*x+y/2-z)/2);
       K[i]:=f*(2*x+y/2-z)/2;
       O[i]:=2*x+y/2-z-f*(2*x+y/2-z);
       f:=f+0.1;
      end;
     end;

    If f=1 then
     begin
       for i:=3 to 3 do
       begin
       L[i]:=x;
       M[i]:=(y/2);
       N[i]:=(3.72*(2*x+y/2-z)/2);
       K[i]:=(2*x+y/2-z)/2;
       f:=f+0.1;
       end;
     end;

    If f>1 then
     begin
       for i:=4 to 13 do
       begin
       L[i]:=x;
       M[i]:=(y/2);
       N[i]:=(f*3.72*(2*x+y/2-z)/2);
       K[i]:=f*(2*x+y/2-z)/2;
       P[i]:=((f-1)*((2*x+y/2-z)/2));
       f:=f+0.1;
       end;
     end;


   end;

For j:=1 to 2 do
    Begin
      fi[j]:=0.7+j*0.1;
      S:=-999999999;
      T:=273;
      While S<hf do
         begin
           If T>1600 then
            begin
             S:=L[j]*(hf1+(b12*(T-273)+c12*(ln(T)-ln(273))))+O[j]*(hf4+(b42*(T-273)+c42*(ln(T)-ln(273))))+M[j]*(hf2+(b22*(T-273)+c22*(ln(T)-ln(273))))+N[j]*(hf3+(b32*(T-273)+c32*(ln(T)-ln(273))));
             T:=T+0.5;
            end;
           If T<=1600 then
            begin
             S:=L[j]*(hf1+(b11*(T-273)+c11*(ln(T)-ln(273))))+ O[j]*(hf4+(b41*(T-273)+c41*(ln(T)-ln(273))))+M[j]*(hf2+(b21*(T-273)+c21*(ln(T)-ln(273))))+ N[j]*(hf3+(b31*(T-273)+c31*(ln(T)-ln(273))));
             T:=T+0.5;
            end;
         end;
      Ta[j]:=T-85.75;
    end;

For j:=3 to 3 do
    Begin
      fi[j]:=0.7+j*0.1;
      S:=-999999999;
      T:=273;
      While S<hf do
         begin
           If T>1600 then
            begin
             S:=L[j]*(hf1+(b12*(T-273)+c12*(ln(T)-ln(273))))+M[j]*(hf2+(b22*(T-273)+c22*(ln(T)-ln(273))))+N[j]*(hf3+(b32*(T-273)+c32*(ln(T)-ln(273))));
             T:=T+0.5;
            end;
           If T<=1600 then
            begin
             S:=L[j]*(hf1+(b11*(T-273)+c11*(ln(T)-ln(273))))+M[j]*(hf2+(b21*(T-273)+c21*(ln(T)-ln(273))))+N[j]*(hf3+(b31*(T-273)+c31*(ln(T)-ln(273))));
             T:=T+0.5;
            end;
         end;
      Ta[j]:=T-85.75;
    end;


For j:=4 to 13 do
    Begin
      fi[j]:=0.7+j*0.1;
      S:=-999999999;
      T:=273;
      While S<hf do
         begin
           If T>1600 then
            begin
             S:=L[j]*(hf1+(b12*(T-273)+c12*(ln(T)-ln(273))))+P[j]*(hf5+(b52*(T-273)+c52*(ln(T)-ln(273))))+M[j]*(hf2+(b22*(T-273)+c22*(ln(T)-ln(273))))+N[j]*(hf3+(b32*(T-273)+c32*(ln(T)-ln(273))));
             T:=T+0.5;
            end;
           If T<=1600 then
            begin
             S:=L[j]*(hf1+(b11*(T-273)+c11*(ln(T)-ln(273))))+P[j]*(hf5+(b51*(T-273)+c51*(ln(T)-ln(273))))+M[j]*(hf2+(b21*(T-273)+c21*(ln(T)-ln(273))))+N[j]*(hf3+(b31*(T-273)+c31*(ln(T)-ln(273))));
             T:=T+0.5;
            end;
         end;
      Ta[j]:=T-85.75;
    end;

For j:=1 to 13 do
Begin
  ListBox1.Items.Add(FloatToStr(Fi[j]));
  ListBox2.Items.Add(FloatToStr(Ta[j])+'K');
end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
form3.show;
  clinha:=1 ;
   while clinha<14 do
    begin
    form3.Chart1.series[0].AddXY(fi[clinha],ta[clinha]);
    clinha:=clinha+1;
end; // do while
end;

end.


