//
//  TodoSelectedItemView.swift
//  odot
//
//  Created by Joakim Eberholst on 2021-01-24.
//

import SwiftUI

struct TodoSelectedItemView: View {
    
    @State var todos: Todos
    @State var todoItem: TodoItem? = nil
    @State var listItemIndex: Int
    
    
    var body: some View {
    
        ZStack {
            
                VStack(alignment: .leading) {
                    
                    NavigationLink(
                        destination: EmptyView().frame(width: 1, height: 1, alignment: .center),
                        label: {
                            
                        })
                        .navigationBarTitle("\(todoItem!.title)")
                    
                    TitleTextView(dateFormatted: todoItem!.getFormattedDate())
                    
                    Group {
                        GroupTitleImageView(systemName: "camera", itemCount: 7)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 7) { i in
                                    ImageRowButton(mainIndex: listItemIndex, imageIndex: i)
                                }
                            }
                        }
                    }
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                    
                    Divider()
                    
                    Group {
                        GroupTitleImageView(systemName: "link", itemCount: 3)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< todoItem!.hyperLinks.capacity, id: \.self){item in
                                    HyperLinkView(hyperLinkItem: todoItem!.hyperLinks[item], itemIndex: item)
                                
                                    
                                }.background(GrayBackGroundView())
                            }
                        }
                    }
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                    
                    Divider()
                    
                    Group {
                        GroupTitleTextCodeBlockView(systemName: "chevron.left.slash.chevron.right")
                        
                            List(){
                                ForEach(0 ..< todoItem!.codeBlocks.capacity){item in
                                    CodeBlockView(blockContent: todoItem!.codeBlocks[item])
                                }
                                .onDelete(perform: { indexSet in
                                    //add delete
                                })
                            }
        
                    }
                    .padding(.init(top: 10, leading: 20, bottom: 10, trailing: 20))
                    Divider()
                    
                    
                }
            }

    }
}


struct TodoSelectedItemView_Previews: PreviewProvider {
    static var todo = Todos()
    
    static var previews: some View {
        TodoSelectedItemView(todos: Todos(), todoItem: todo.listOfItems[3], listItemIndex: 3)
    }
}

struct GrayBackGroundView: View {
    
    var body: some View {
        Color.init(UIColor.systemGray4.withAlphaComponent(0.2))
            .cornerRadius(10)
    }
    
}

struct ImageRowButton: View {
    
    var mainIndex: Int
    var imageIndex: Int
    
    var body: some View {
        
        Button(action: {
            print("MainIndex: \(mainIndex) ImageIndex: \(imageIndex)" )
        }, label: {
            Image(systemName: "photo")
                .padding()
                .foregroundColor(Color.black)
        })
        .background(GrayBackGroundView())

    }
}

struct CodeBlockView: View {
    
    var blockContent: String
    
    var body: some View {
        
    
        VStack{
            
            NavigationLink(
                destination: CodeBlockEditView(codeBlock: blockContent),
                label: {
                    Text("\(blockContent)")
                        //.padding()
                       .font(.system(size: 12))
                })
               
        }
        .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .leading)
        
        
        
    }
    
}

struct HyperLinkView: View {
    
    var hyperLinkItem: HyperLinkItem
    var itemIndex: Int
    
    var body: some View {
        
        NavigationLink(
            destination: HyperLinkEditView(hyperLinkItem: hyperLinkItem),
            label: {
                VStack(alignment: .center) {
                    
                    Text("\(hyperLinkItem.title)")
                        .bold()
                        .foregroundColor(.black)
                    Text("\(hyperLinkItem.description)")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                    Text("\(hyperLinkItem.hyperlink.prefix(20) + "...")")
                        .font(.system(size: 14))
                        .foregroundColor(.blue)
                        
                }
                .frame(width: UIScreen.main.bounds.width/2, height: 100, alignment: .center)
            })
           
    }
}

struct GroupTitleImageView: View {
    
    var systemName: String
    var itemCount: Int
    
    var body: some View {
        
        HStack {
            
            Image(systemName: "\(systemName)")
                .resizable()
                .foregroundColor(.black)
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            
            Text("\(itemCount)")
                .foregroundColor(.black)
                .underline()
                
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "plus")
            })
        }
        
        
    }
}

struct GroupTitleTextCodeBlockView: View {
    
    var systemName: String
    //var itemCount
    
    var body: some View {
        
        HStack {
            Image(systemName: "\(systemName)")
                .resizable()
                .foregroundColor(.black)
                .aspectRatio(contentMode: .fit)
                .frame(width: 32, height: 32)
                .padding(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
            
            Text("4")
                .underline()
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "plus")
            })
        }
        
        
    }
}

struct TitleTextView: View {
    
    var dateFormatted: String
    
    var body: some View {
        Text("\(dateFormatted)")
            .font(.system(size: 10))
            .padding(.init(top: 20, leading: 25, bottom: 15, trailing: 0))
    }
}
