//
//  ContentView.swift
//  RecipesApp
//

import SwiftUI
import CachedAsyncImage

struct ContentView: View {
    @State private var isConnected = false
    @StateObject var viewModel = RecipesViewModel(networkProtocol: NetworkManager())
    let networkMonitor: Reachability
    init(networkMonitor: Reachability){
        self.networkMonitor = networkMonitor
    }
    func refreshData() async {
        Task{
            await viewModel.fetchRecipes()
        }
    }
    
    var body: some View {
        NavigationView {
            if isConnected{
                if viewModel.recipesList.count > 0{
                    List(viewModel.recipesList,id: \.id){value in
                        LazyHStack
                        {
                            CachedAsyncImage(url: URL(string: value.photo_url_small ?? ""))
                                .frame(width: 80,height: 80)
                                .clipShape(Circle())
                            
                            LazyVStack(alignment: .leading)
                            {
                                Text(value.name ?? "")
                                    .frame(maxWidth: .infinity)
                                Text(value.cuisine ?? "")
                                    .frame(maxWidth: .infinity)
                            }
                            
                        }
                    }
                    .refreshable {
                        await refreshData()
                    }
                    .scrollContentBackground(.hidden)
                    .background(Color.accentColor.opacity(0.4))
                }else{
                    Text("No Recipe Found")
                }
            }else{
                NetworkUnavailableView()
            }
        }
        .onAppear(){
            Task{
                isConnected = networkMonitor.execute()
                await refreshData()
            }
        }
    }
}

#Preview {
    ContentView(networkMonitor: NetworkConnection())
}
