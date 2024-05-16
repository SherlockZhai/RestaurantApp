

import SwiftUI

struct HomeView: View {
    @AppStorage("isLogin") var isLogin: Bool = false
    @EnvironmentObject var vm: TableListViewModel
    @Environment(\.colorScheme) private var scheme
    @State private var showToast = false
    
    @State private var selectedDate = Date()
        @State private var showAlert = false
    @State private var table_id = 0
    @State private var table_no = ""
    
    
    var body: some View {
        ScrollView {
            VStack(spacing:16) {
                HStack(spacing: 16){
                    Image(systemName: "fork.knife.circle").resizable()
                        .frame(width: 42, height: 42,alignment: .leading)
                        .foregroundColor(.purple)
                    VStack(alignment: .leading,spacing: 8){
                        Text("Delicious Restaurant").font(.title2).foregroundColor(.blue)
                        Text("Business hour: 09:00-22:00").font(.subheadline).foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Image(systemName: "phone").resizable()
                        .frame(width: 20, height: 20,alignment: .trailing)
                        .foregroundColor(.red)
                        .onTapGesture {
                            if let url = URL(string: "tel://13812345678") {
                                            UIApplication.shared.open(url)
                                        }
                        }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 10)
                .frame(maxWidth: .infinity)
                .background(.white)
            .background(.ultraThinMaterial,in:RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                
                HStack{
                    Image(systemName: "book").foregroundColor(.gray)
                    Text("Please make a table reservation, you can cancel your reservation")
                        .font(.callout)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundColor(.gray)
                    
                }
                
                LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 8)  {
                    ForEach(vm.dataArray,id: \.id){ item in
                        VStack(spacing: 8){
                            Text("Table \(item.table_no)").font(.title2)
                            Button(action: {
                                showAlert = true
                                table_id = item.id
                                table_no = item.table_no
                            }, label: {
                                Text("Reserve").frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 30)
                                    .background(item.status == 2 ? .gray : .green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }).disabled(item.status == 2)
                                
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 10)
                        .frame(maxWidth: .infinity)
                        .background(.white)
                    .background(.ultraThinMaterial,in:RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                    }
                }
                
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
        }
        .overlay(ToastView(presenting: self, message: "Booking successful！", show: $showToast))
        .background(Color("BgColor"))
        .onAppear{
            vm.loadData()
        }
        .safeAreaInset(edge: .top, content: {
            Color.clear.frame(height: 60)
        })
        .overlay {
            ZStack {
                Color.clear.background(.ultraThinMaterial).blur(radius: 10)
                    .opacity( 0.8)
                   
                
                HStack(spacing: 16){
                    Image(systemName: "person.circle.fill")
                        .resizable().aspectRatio(contentMode: .fit)
                        .frame(width:  40, height:  40)
                        .background(
                            Circle()
                                .trim(from: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/,to: 1)
                                .fill(Color.orange.opacity(0.25))
                                .stroke(Color.white,
                                        lineWidth: 1)
                                .frame(width:44,height:  44)
                        )
                    
                    VStack(alignment: .leading){
                        Text(vm.user.account).font(.title2)
                        Text(vm.user.phone).font(.callout)
                    }
                    
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    
                    Button {
                        isLogin = false
                        vm.user.id = 0
                    } label: {
                        Text("Logout")
                    }
                    .padding(.horizontal,20)
                    .padding(.vertical,8)
                    .background(.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top,20)
            }
            .frame(height:  60)
            .frame(maxHeight: .infinity,alignment: .top )
        }
        .sheet(isPresented: $showAlert, content: {
         
                VStack{
                    
                        DatePicker("Select a date", selection: $selectedDate,in: Date()..., displayedComponents: [.date, .hourAndMinute])
                            .environment(\.locale, Locale(identifier: Locale.current.identifier))
                    Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                    
                    Button(action: {
                        showAlert = false
                        booking(id: table_id,table_no: table_no)
                    }) {
                        
                        HStack {
                            Text("Save")
                                .frame(maxWidth: .infinity)
                                .padding()
                        }
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()
                }
                .padding(.vertical,20)
                .padding(.horizontal,20)
                .presentationDetents([.medium])
                .presentationDragIndicator(.visible)
         
            
            
        })
    }
    
    
    func booking(id: Int,table_no: String){
        withAnimation {
            showAlert = false
            //list.append((date: Date(),num: i,status: 0))
            vm.booking(id: id, table_no: table_no, userId: vm.user.id, phone: vm.user.phone, appointment_time: selectedDate)
            showToast.toggle()
                           DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                               showToast.toggle()
                           }
        }
    }
    
    
}

#Preview {
    ContentView()
}
