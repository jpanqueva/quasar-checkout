<template>
  <q-item
    clickable
    tag="a"
    @click="goCheckOut()"
  >
    
    <q-item-section>
      <div class="row">
        <div class="col">
          <q-img
            :src="imgsrc"
            spinner-color="white"
            style="height: 140px; max-width: 150px"
          />
        </div>  
        <div class="col">
          <p><strong>{{title}}</strong></p>
          <p><q-icon name="today" /> {{date}} </p>
          <p><q-icon name="payments" /> $ {{price}} </p>
          <p><q-btn
      
              rounded
              :dense="true"
              color="primary"
              
              label="Comprar"
            />
          </p>
        </div>
      </div>
      
      
      
    </q-item-section>

  </q-item>
</template>

<script>
import { defineComponent } from 'vue'

export default defineComponent({
  name: 'EventoItem',
  props: {

    imgsrc: {
      type: String,
      default: 'https://as2.ftcdn.net/v2/jpg/00/27/69/37/1000_F_27693752_kijFHtGV0K9dMcHS19xX8cUxhXATQ4B1.jpg'
    },

    title: { 
      type: String,
      default: 'Titulo del evento'
    },
    price: {
      type: Number,
      default: 10000
    },
    date: {
      type: String,
      default: "Enero 1 de 2023"
    }
  },
  methods:{
    goCheckOut () {
      localStorage.title = this.title;
      localStorage.imgsrc = this.imgsrc;
      localStorage.price = this.price;
      localStorage.date = this.date;
      this.$router.push('checkout');
    }
  }
})
</script>
