
import SwiftUI

struct MyBookingView: View {
    
    @EnvironmentObject var vm: TableListViewModel
    
    @State private var showToast = false
    
    @State private var selectedOption = 0
    
    let options = ["Reserving", "Canceled", "Reserved"]
        
    var filterList : [OrderInfo] {
        
        let newList = vm.orderList.filter{
            $0.status == selectedOption + 1
        }
        
        return newList;
    }
    
    var body: some View {
        VStack{
            Picker("Select an option", selection: $selectedOption) {
                ForEach(0..<options.count,id:\.self) { index in
                               Text(options[index])
                           }
                       }
                       .pickerStyle(SegmentedPickerStyle())
            List{
                ForEach(filterList,id: \.id){ item in
                    HStack(spacing: 8){
                        VStack(alignment: .trailing, spacing: 8){
                            Text("Table：\(item.table_no)")
                                .font(.body.weight(.bold))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            if selectedOption == 0 {
                                Text("Table \(item.table_no) Reserved")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                            }
                            if selectedOption == 1 {
                                Text("Canceled")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                            }
                            if selectedOption == 2 {
                                Text("Fininshed")
                                    .font(.subheadline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        .frame(width: .infinity)
                        
                        Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .trailing){
                            Text(item.appointment_time, format: Date.FormatStyle(date: .omitted))
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                            if selectedOption == 0 {
                                Button(action: {
                                    cancelBooking(id: item.id)
                                }, label: {
                                    Text("Cancel").frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/,height: 30)
                                        .background(.green)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                })
                            }
                        }
                    }
                    .padding(.horizontal,4)
                }
            }
            .listStyle(.plain)
            
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .overlay(ToastView(presenting: self, message: "Canceled Booking successful！", show: $showToast))
        //.background(Color("BgColor"))
        .onAppear{
            vm.loadOrderList(userId: vm.user.id)
        }
        
    }
    
    func cancelBooking(id: Int){
        withAnimation {
            vm.cancelBooking(id: id)
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
