<template>
    <div class="max-w-sm m-auto my-8">
        <div class="border p-10 border-grey-light shadow rounded">
            <h3 class= "text-2x1 mb-6 text-grey-darkest">Sign In</h3>
            <form @submit.prevent="signin">
                <div class="text-red" v-if="error">{{"error"}}</div>

                <div class="mb-6">
                    <label for="email" class="label">E-mail Address</label>
                    <input type="email" v-model="email" class="input" id="email" placeholder="andy@web-crunch.com"> 
                </div>

                <div class="mb-6">
                    <label for="password" class="label">password</label>
                    <input type="password" v-model="password" class="input" id="password"> 
                </div>

                <button type="submit" class= "font-sans font-bold px-4 rounded cursor-pointer no-underline
                bg-green hover:bg-green-dark block w-full py-4 text-white items-center justify-center">
                Sign In</button>

                <div class="my-4">
                    <router-link to="/signup" class="link-grey">Sign Up</router-link>
                </div>
            </form>
        </div>
    </div>
</template>

<script>


export default {
    name: 'Signin',
    data() {
        return{
            email: '',
            password: '',
            error: ''
        }
    },
    created (){
        this.checkSignedIn()
    },
    updated(){
        this.checkSignedIn()
    },
    methods: {
        signin(){
            this.$http.plain.post('/signin', {email: this.email, password: this.password})
            .then(response => this.signinSuccesful(response))
            .catch(error => this.signinFailed(error))
        },
        signinSuccesful (response){
            if (!Response.data.csrf){
                this.signinFailed(response)
                return
            }

            localStorage.csrf = response.dat.csrf
            localStorage.signedIn = true
            this.error = ''
            this.$router.replace('/records')
        },
        signinFailed(error){
            
            this.error = ( error.response && error.data && error.response.data.error) || ''
            delete localStorage.csrf
            delete localStorage.signedIn
        },
        checkSignedIn(){
            if(localStorage.signedIn){
                this.$router.replace('/records')
            }
        }
    
    }
}

</script>
