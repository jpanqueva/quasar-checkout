<template>
    <q-page>
        <h3>Realizar Compra</h3>
        <q-card v-if="false" class="my-card">
            <q-card-section>
                <div class="row q-pa-md">
                    <div class="col q-pa-md">
                        <q-img
                        :src="imgsrc"
                        spinner-color="white"
                            />
                    </div>
                    <div class="col q-pa-md">
                        <strong>{{ title }}</strong>
                        <p>Fecha: {{date}}</p>
                        <p>Precio por persona: $ {{price}}</p>
                    </div>
                </div>        
            </q-card-section>
        </q-card>

        <div class="row q-m-md">
            <div class="col-8 q-pa-md">
                
                <q-card class="my-card q-mt-md" style="font-size: 12px;">
                    <q-card-section>
                        <strong>Entrada digital - Gratis</strong>
                        <p>Entrada valida para: {{date}}</p>
                        <small>Esta entrada no es transferible, una vez realizada la compra recibirá un email con instrucciones</small>
                    </q-card-section>
                </q-card>

                
                <q-card class="my-card q-mt-md q-pa-md">
                    <q-card-section>
                        <span> Pago: <q-icon name="check_circle" style="color: rgb(45 88 45);" /> </span>
                        <p class="q-mt-md q-ml-sm">Targeta de credito</p>

                        
                    </q-card-section>

                    <q-list bordered>
                        <q-item v-for="(item, index) in cards" :key="index" tag="label" v-ripple>
                            <q-item-section avatar top>
                                <q-radio v-model="cardSelection" :val="index" color="cyan" />
                            </q-item-section>
                            <q-item-section>
                                <q-item-label caption>
                                    <div class="row">
                                       <Strong> Visa - {{getLastFourNumber(item.number)}} </Strong>
                                    </div>
                                    <div class="row" style="font-size: 8px;" >
                                       {{item.name}} | Exp {{item.month}}/{{this.year}}
                                    </div>
                                    <div class="row">
                                        <q-btn padding="none" @click="editar(index)" flat color="primary" label="Editar" size="xs" /> | <q-btn @click="eliminar(index)"  padding="none" flat color="primary" label="Eliminar" size="xs"/> 
                                    </div>   
                                    <div v-if="index == cardSelection" >
                                        <div class="row">
                                            <span class="q-mt-sm">Código de seguridad</span>
                                        </div>
                                        <div class="row">
                                            <q-input
                                            v-model="cvsCardUnBlock"
                                            mask="###"
                                            filled
                                            type="password"
                                            unmasked-value
                                            :dense="true" 
                                            style="width: 100px"
                                            
                                            /> 
                                            <q-icon name="credit_card" size="3em" /> 
                                            <span class="q-pt-md">3-digitos cvs</span>
                                        </div>
                                    </div>        
                                </q-item-label>
                            </q-item-section>
                        </q-item>
                    </q-list>

                    <q-card-section>
                        <q-btn outline color="primary" label="Nueva Tarjeta" @click="addCard()" icon="credit_card" />
                    </q-card-section>
                </q-card>

                
            </div>
            <div class="col-4 q-pa-md">
                 <q-card class="my-card  q-mt-md q-pa-md">
                    <q-card-section>
                        <span> Cantidad:</span>
                        <q-input
                            v-model="cantidad"
                            type="number"
                            filled
                            @change="calcularValores()"
                            :dense="true"
                            style="max-width: 200px"
                            />
                    </q-card-section>

                    <q-card-section style="font-size: 10px;">
                        <div class="row" style="font-size: 13px;">
                            <div class="col">
                                <strong>Total</strong>
                            </div>
                            <div class="col text-right	">
                                <strong>$ {{total}} </strong>
                            </div>
                        </div>

                        <div class="row q-mt-md">
                            <strong>Entrada</strong>
                        </div>

                        <div class="row q-mt-sm">
                            <div class="col-8">
                                Entrada a {{title}} X {{cantidad}}
                            </div>
                            <div class="col-4 text-right	">
                                <strong>$ {{valor_entradas}}</strong>
                            </div>
                        </div>

                        <div class="row q-mt-md">
                            <strong>Notas</strong>
                        </div>

                        <div class="row q-mt-sm">
                            <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam</p>
                        </div>

                        <div class="row q-mt-md">
                            <strong>Comisiones</strong>
                        </div>

                        <div class="row q-mt-sm">
                            <div class="col">
                                Costos del servicio
                            </div>
                            <div class="col text-right	">
                                $ {{valor_costo_servicio}}
                            </div>
                        </div>
                        <div class="row q-mt-sm">
                            <div class="col">
                                Costo de transacciòn
                            </div>
                            <div class="col text-right	">
                                $ {{valor_procesamiento_pedido}} 
                            </div>
                        </div>

                        <q-btn class="q-mt-md" padding="none" @click="this.$router.push('/')" flat color="primary" label="Cancelar Compra" size="xs" /> 

                        <div class="row q-mt-md">
                            <strong>No hay devoluciones</strong>
                        </div>

                        <div class="row q-mt-sm">
                            <q-checkbox v-model="terminos_y_condiciones" label="Acepto terminos y condiciones" />
                        </div>

                        <div class="row">
                            <q-btn
                            size="14px"
                            class="q-px-xl q-py-xs"
                            color="green"
                            label="Realizar Compra"
                            @click="realizarCompra()"
                            />
                        </div>
                        
                    </q-card-section>
                </q-card>

            </div>
        </div>
         
        
        <q-dialog v-model="showPopup_addCard">
            
                <q-card>
                    <q-form
                    class="q-gutter-md"
                    @submit="saveCard()"
                    >
                        <q-card-section>
                        <div class="text-h6">Datos de la tarjeta</div>
                        </q-card-section>

                        <q-card-section class="q-pt-none">
                            
                            <q-input
                            v-model="nameCard"
                            filled
                            label="Nombre" 
                            style="width: 250px"
                            :rules="[ val => val && val.length > 0 || 'Es requerido']"
                            />

                            <q-input
                            v-model="numberCard"
                            mask="#### - #### - #### - ####"
                            filled
                            fill-mask="#"
                            unmasked-value
                            label="Número" 
                            style="width: 250px"
                            :rules="[ val => val && val.length == 16 || 'Se esperan 16 numeros']"
                            />

                            <div class="row">
                                <div class="col-6 q-pa-sm">
                                    <q-select 
                                    filled 
                                    v-model="dateCard_year" 
                                    :options="optionsYears" 
                                    label="Año"
                                    :rules="[val => !!val || 'Este campo es requerido']"
                                     />
                                </div>
                                <div class="col-6 q-pa-sm">
                                    <q-select 
                                    filled 
                                    v-model="dateCard_month" 
                                    :options="optionsMoth" 
                                    label="Mes"
                                    :rules="[val => !!val || 'Este campo es requerido']"
                                    />
                                </div>
                            </div>


                            <q-input
                            v-model="cvsCard"
                            mask="###"
                            filled
                            type="password"
                            unmasked-value
                            label="CVS" 
                            style="width: 250px"
                            :rules="[ val => val && val.length == 3 || 'se esperan 3 numeros']"
                            />


                        </q-card-section>

                        <q-card-actions align="right">
                        <q-btn  type="submit" label="Agregar" color="primary"  />
                        <q-btn flat label="Cancelar" color="primary" v-close-popup />
                        </q-card-actions>
                    </q-form>
                </q-card>
        </q-dialog>
        <q-dialog v-model="ShowPopup_acepte_terminos">
            <q-card>
                
                <q-card-section>
                    <div class="text-h6">Terminos y condiciones</div>
                </q-card-section>
                <q-card-section class="q-pt-none">
                    Debe aceptar los terminos y condiciones
                </q-card-section>

                <q-card-actions align="right">
                <q-btn flat label="OK" color="primary" v-close-popup />
                </q-card-actions>
            </q-card>
        </q-dialog>
        <q-dialog v-model="ShowPopup_compraFinalizada">
            <q-card>
                
                <q-card-section>
                    <div class="text-h6">Gracias</div>
                </q-card-section>

                <q-card-section class="q-pt-none">
                    Compra finalizada
                </q-card-section>

                <q-card-actions align="right">
                <q-btn flat label="OK" color="primary" v-close-popup />
                </q-card-actions>
            </q-card>
        </q-dialog>
        <q-dialog v-model="ShowPopup_cvs_pendiente">
            <q-card>
                
                <q-card-section>
                    <div class="text-h6">Seleccion Tarjeta</div>
                </q-card-section>

                <q-card-section class="q-pt-none">
                    Debe seleccionar una tarjeta e ingresar en codigo CVS
                </q-card-section>

                <q-card-actions align="right">
                <q-btn flat label="OK" color="primary" v-close-popup />
                </q-card-actions>
            </q-card>
        </q-dialog>
    </q-page>
  </template>

  <style>
    .q-page {
        max-width: 1000px;
        margin: 0 auto;
    }
</style>

  <script>
  import { defineComponent } from 'vue'
  import { date } from 'quasar'

  const eventos= [
  ]
  
  export default defineComponent({
    name: 'CheckoutPage',
    data () {
        return {
            title: '',
            imgsrc: '',
            price: '',
            date: '',
            cantidad:1,
            showPopup_addCard:false,
            nameCard:'',
            numberCard: '',
            dateCard_month: '',
            dateCard_year: '',
            cvsCard: '',
            optionsYears: [],
            optionsMoth: [],
            cards:[{
                number:'1234123412341234',
                month:'1',
                year:'2022',
                cvs:'000',
                name:'Jhon R'
            },{
                number:'1234123412341235',
                month:'2',
                year:'2021',
                cvs:'001',
                name:'Jhon P'
            }],
            cardSelection:0,
            cvsCardUnBlock:'',
            intextEdit:-1,
            total:0,
            valor_entradas:0,
            valor_costo_servicio:0,
            valor_procesamiento_pedido:0,
            terminos_y_condiciones:false,
            ShowPopup_acepte_terminos:false,
            ShowPopup_compraFinalizada:false,
            ShowPopup_cvs_pendiente:false
        }
    },
    created () {
        this.title = localStorage.title;
        this.imgsrc = localStorage.imgsrc;
        this.price = localStorage.price;
        this.date = localStorage.date;
        const newDate = new Date()

        for(let i = 2000;i < newDate.getFullYear();i++) {
            this.optionsYears.push(i+'')
        }
        for (let i = 1 ; i <= 12; i++) {
            this.optionsMoth.push(i+'');
        }
        this.calcularValores();
    },
    components: {
      
    },
    methods: {
        addCard() {
            this.numberCard ='';
            this.dateCard_month ='';
            this.dateCard_year ='';
            this.cvsCard ='';
            this.nameCard = '';
            
            this.intextEdit = -1;
            this.showPopup_addCard = true;
        },
        saveCard () {
            if(this.intextEdit != -1) {
                this.cards[this.intextEdit] ={
                number:this.numberCard,
                month:this.dateCard_month,
                year:this.dateCard_year,
                cvs:this.cvsCard,
                name:this.nameCard
                };
            }else {
                this.cards.push({
                number:this.numberCard,
                month:this.dateCard_month,
                year:this.dateCard_year,
                cvs:this.cvsCard,
                name:this.nameCard
                })
            }
            this.showPopup_addCard = false;
            this.numberCard ='';
            this.dateCard_month ='';
            this.dateCard_year ='';
            this.cvsCard ='';
            this.nameCard = '';
            this.intextEdit = -1;
        },
        getLastFourNumber (s) {
            return s.substr(s.length - 4);
        },
        editar (index) {
            var item = this.cards[index];
            this.numberCard =item.number;
            this.dateCard_month =item.month;
            this.dateCard_year =item.year;
            this.cvsCard =item.cvs;
            this.nameCard = item.name;
            this.intextEdit = index;
            this.showPopup_addCard = true;
        },
        eliminar(index){
            this.cards = this.deleteItemByIndex(this.cards,index)
        },
        deleteItemByIndex(array, index) {
            if (index > array.length - 1) {
                return array;
            }
            return array.slice(0, index).concat(array.slice(index + 1));
        },
        calcularValores () {
            if(this.cantidad <= 0){
                this.cantidad = 1;
            }
            this.valor_entradas = this.price *this.cantidad;
            this.valor_costo_servicio = this.valor_entradas * 0.05;
            this.valor_procesamiento_pedido = this.valor_entradas * 0.02;
            this.total = this.valor_entradas + this.valor_costo_servicio + this.valor_procesamiento_pedido;
        },
        realizarCompra () {
            if(this.terminos_y_condiciones == false){
                this.ShowPopup_acepte_terminos = true;
                return;
            }
            if(this.cvsCardUnBlock.length != 3) {
                this.ShowPopup_cvs_pendiente = true;
                return;
            }
            this.ShowPopup_compraFinalizada = true;
        }
    }

      
  })
  </script>
  