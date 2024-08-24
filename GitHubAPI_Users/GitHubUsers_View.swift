import SwiftUI
//start
struct GitHubUsers_View : View {
    var body: some View {
        //        Text("GitHubUsers_API")
        
        NavigationView{
            VStack{
                
                TextField("user ", text: <#T##Binding<String>#>)
                
                
                
            }
            .navigationTitle("Github Users")
            
            
        }
    }
}


#Preview {
    GitHubUsers_View()
}
