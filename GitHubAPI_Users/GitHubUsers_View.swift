import SwiftUI
//start
struct GitHubUsers_View : View {
    
    @StateObject var viewModel = GitHubUsers_ViewModel()
    @State var inputText : String = ""
    
    
    
    var body: some View {
        //        Text("GitHubUsers_API")
        
        NavigationView{
            VStack{
                
                HStack{
                    TextField("user name... ", text: $inputText)
                        .padding()
                        .frame(width: 250 , height: 50)
                        .border(Color.black, width: 3)
                        .padding()
                        Button(action: {
                            
                            print("Search : \(inputText)")
                            
                        }, label: {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.black, lineWidth: 3)
                                .frame(width: 70 ,height: 50)
                                .overlay {
                                    Text("Search")
                                        .font(.system(size: 15))
                                        .fontWeight(.black)
                                        .foregroundStyle(.black)
                                }
                        })
                        .disabled( inputText.isEmpty ? true : false)
                    }
                
                List(viewModel.users) { user in
                    HStack {
                        AsyncImage(url: URL(string: user.avatar_url)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } placeholder: {
                            ProgressView()
                        }
                        VStack(alignment: .leading) {
                            Text(user.login)
                                .font(.headline)
                            Text(user.html_url)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                }
                
            }
            .navigationTitle("Github Users")
            
            
        }
    }
}


#Preview {
    GitHubUsers_View()
}
