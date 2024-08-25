import SwiftUI
import Combine
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
                        .onChange(of: inputText) { oldValue, newValue in
                            if !newValue.isEmpty {
                                viewModel.searchQuery = newValue
                            } else {
                                viewModel.users = []
                            }
                        }
                    Button(action: {
                        
                        print("Search : \(inputText)")
                        viewModel.searchUser(inputText)
                        
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
                        //                        AsyncImage(url: URL(string: user.avatar_url)) { image in
                        //                            image.resizable()
                        //                                .aspectRatio(contentMode: .fit)
                        //                                .frame(width: 50, height: 50)
                        //                                .clipShape(Circle())
                        //                        } placeholder: {
                        //                            ProgressView()
                        //                        }
                        AsyncImage(url: URL(string: user.avatar_url)) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                        } placeholder: {
                            Color.gray // 기본 이미지
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
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
            .onAppear(perform: {
                viewModel.getUsers()
                
                
            })
        }
    }
}


#Preview {
    GitHubUsers_View()
}
