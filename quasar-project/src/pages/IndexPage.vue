<template>
  <q-page >

    <h3>Proximos eventos</h3>
    <q-card class="my-card q-mt-md" style="font-size: 12px;">
        <q-card-section>
          <q-list bordered>
            <EventoItem v-for="item in eventos" :key="item.title" :title="item.title" :date="item.date" :price="item.price" :imgsrc="item.img"  />
          </q-list>
        </q-card-section>
    </q-card>

    
    
  </q-page>
</template>

<style>
.q-page {
    max-width: 400px;
    margin: 0 auto;
}
</style>

<script>
import { defineComponent } from 'vue'
import EventoItem from 'src/components/EventoItem.vue'

const eventos= [
  {
    title:"Título de evento de prueba 1",
    img:"https://as2.ftcdn.net/v2/jpg/00/27/69/37/1000_F_27693752_kijFHtGV0K9dMcHS19xX8cUxhXATQ4B1.jpg",
    price:20000,
    date:"2 de Enero de 2023",
  },
  {
    title:"Título de evento de prueba 2",
    img:"https://as2.ftcdn.net/v2/jpg/00/86/59/07/1000_F_86590753_muk3H2ELA5tqD3dIN8wmOt3W36irooNR.jpg",
    price:30000,
    date:"10 de Enero de 2023",
  },
  {
    title:"Título de evento de prueba 2",
    img:"https://as2.ftcdn.net/v2/jpg/00/03/53/41/1000_F_3534153_qJgQwoBh5JBi5oCiaST0WyqZNB0Xvn.jpg",
    price:40000,
    date:"15 de Enero de 2023",
  },
]

export default defineComponent({
  name: 'IndexPage',
  data () {
    return {
      eventos
    }
  },
  components: {
    EventoItem
  }
})
</script>
